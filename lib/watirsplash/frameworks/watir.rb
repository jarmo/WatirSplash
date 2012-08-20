WatirSplash::Frameworks::Helper.load_gems "watir-classic"
require "watir-classic/ie"

# patches for Watir
module Watir
  class IE #:nodoc:all
    alias_method :_initialize, :initialize

    def initialize suppress_new_window=nil
      _initialize suppress_new_window
      self.speed = :fast
    end
  end

  class Element 
    # saves a file with the browser
    #
    # clicking the button opens a browser's save as dialog and saves the file document.pdf
    #  button(:id => "something").save_as("c:/document.pdf") # => c:/document.pdf
    #
    # * raises an exception if saving the file is unsuccessful
    # * returns saved file path
    def save_as(file_path)
      path = Pathname.new(file_path)
      raise "path to #{file_path} has to be absolute!" unless path.absolute?
      self.click_no_wait

      browser_window = page_container.rautomation
      
      if page_container.class.version.to_i >= 9
        browser_window.child(:title => "Windows Internet Explorer").button(:value => "Save &as").click
      else
        browser_window.child(:title => "File Download").button(:value => "&Save").click
      end

      save_as_window = browser_window.child(:title => "Save As")
      save_as_window.text_field(:class => "Edit", :index => 0).set(WatirSplash::Util.file_native_path(file_path))
      save_as_window.button(:value => "&Save").click

      Wait.until {File.exists?(file_path)}
      file_path
    end
  end

end
