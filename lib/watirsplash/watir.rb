module Watir
  module PageCheckers
    # raises an error if javascript error was found
    JAVASCRIPT_ERRORS_CHECKER = lambda {|ie| raise "Got JavaScript error!" if ie.status =~ /Error on page/}
  end
end

# patches for Watir
module Watir
  class IE #:nodoc:all
    include WaitHelper
  end

  class Element #:nodoc:all
    include ElementExtensions

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
      AutoIt::Window.new("File Download").button("&Save").click
      save_as_window = AutoIt::Window.new("Save As")
      save_as_window.text_field("Edit1").set(File.native_path(file_path))
      save_as_window.button("&Save").click
      WaitHelper.wait_until {File.exists?(file_path)}
      file_path
    end
  end

  class FileField < InputElement
    def set(file_path)
      raise "#{file_path} has to exist to set!" unless File.exists?(file_path)
      assert_exists
      self.click_no_wait
      window = AutoIt::Window.new(/choose file( to upload)?/i)
      window.text_field("Edit1").set(File.native_path(file_path))
      window.button("&Open").click
    end
  end

end