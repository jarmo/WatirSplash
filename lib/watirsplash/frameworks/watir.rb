begin
  gem "watir", "1.7.1"
  require "watir"
rescue Gem::LoadError
  puts "Unable to load Watir gem. Install it with 'gem install watir -v 1.7.1'"
  exit 1
end

require "watir/ie"

module Watir
  module PageCheckers
    # raises an error if javascript error was found
    JAVASCRIPT_ERRORS_CHECKER = lambda {|ie| raise "Expected no JavaScript errors to appear on page, but having some!" if ie.status =~ /Error on page/}
  end
end

# patches for Watir
module Watir
  class IE #:nodoc:all
    alias_method :_initialize, :initialize

    def initialize suppress_new_window=nil
      _initialize suppress_new_window
      self.speed = :fast
      add_checker Watir::PageCheckers::JAVASCRIPT_ERRORS_CHECKER
      maximize
    end
  end

  class Element 
    # saves a file with the browser
    #
    # clicking the button opens a browser's save as dialog and saves the file document.pdf
    #  button(:id => "something").download("c:/document.pdf") # => c:/document.pdf
    #
    # * raises an exception if saving the file is unsuccessful
    # * returns saved file path
    def save_as(file_path)
      path = Pathname.new(file_path)
      raise "path to #{file_path} has to be absolute!" unless path.absolute?
      self.click_no_wait
      RAutomation::Window.new(:title => "File Download").button(:value => "&Save").click

      save_as_window = RAutomation::Window.new(:title => "Save As")
      save_as_window.text_field(:class => "Edit", :index => 0).set(File.native_path(file_path))
      save_as_window.button(:value => "&Save").click

      Wait.until {File.exists?(file_path)}
      file_path
    end
  end

  class FileField < InputElement
    def set(file_path)
      raise "#{file_path} has to exist to set!" unless File.exists?(file_path)
      assert_exists
      self.click_no_wait
      window = RAutomation::Window.new(:title => /choose file( to upload)?/i)
      window.text_field(:class => "Edit", :index => 0).set(File.native_path(file_path))
      window.button(:value => "&Open").click
    end
  end

end
