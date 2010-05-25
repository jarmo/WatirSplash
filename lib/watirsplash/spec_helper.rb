module WatirSplash
  # main helper module
  #
  # these methods can be used in specs directly
  module SpecHelper
    include Waiter

    # opens the browser at specified url
    def open_browser_at url
      @browser = Watir::Browser.new
      @browser.speed = :fast
      add_checker Watir::PageCheckers::JAVASCRIPT_ERRORS_CHECKER
      begin
        formatter.browser = @browser
      rescue
      end
      goto url
      maximize
    end

    # downloads file with browser
    #
    # you need to use click_no_wait to use this method:
    #   button(:id => "something").click_no_wait # opens a browser save as dialog
    #   download_file("document.pdf")
    #
    # * raises an exception if saving the file is unsuccessful
    # * returns absolute file_path of the saved file
    def download_file file_name
      AutoItHelper.click_save
      file_path = native_file_path(file_path(file_name))
      AutoItHelper.set_edit(file_path)
      AutoItHelper.click_save("Save As")
      wait_until {File.exists?(file_path)}
      file_path
    end

    # returns WatirSplash::HtmlFormatter object, nil if not in use
    def formatter
      @formatter ||= Spec::Runner.options.formatters.find {|f| f.kind_of?(WatirSplash::HtmlFormatter) rescue false}
    end

    # returns unique file path for use in examples.
    #
    # all file names generated with this method will
    # be shown on the report upon test failure.
    def file_path(file_name, description=nil)
      formatter.file_path(file_name, description)
    end

    # returns native file path
    # e.g. on Windows:
    #   native_file_path("c:/blah/blah2/file.txt") => c:\\blah\\blah2\\file.txt 
    def native_file_path(file_path)
      File::ALT_SEPARATOR ? file_path.gsub(File::SEPARATOR, File::ALT_SEPARATOR) : file_path
    end

    def method_missing name, *arg #:nodoc:
      @browser.respond_to?(name) ? @browser.send(name, *arg) : super
    end

  end
end