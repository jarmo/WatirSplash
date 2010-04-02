module WatiRspec
  # main helper module
  #
  # these methods can be used in specs directly
  module SpecHelper

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
      file_path = formatter.native_file_path(file_name)
      AutoItHelper.set_edit(file_path)
      AutoItHelper.click_save("Save As")
      wait_until! {File.exists?(file_path)}
      file_path
    end

    def method_missing name, *arg #:nodoc:
      @browser.respond_to?(name) ? @browser.send(name, *arg) : super
    end

    # waits until some condition is true and
    # throws Watir::Exception::TimeOutException upon timeout
    #
    # examples:
    #   wait_until! {text_field(:name => 'x').exists?} # waits until text field exists
    #   wait_until!(5) {...} # waits maximum of 5 seconds condition to be true
    def wait_until! *arg
      Watir::Waiter.wait_until(*arg) {yield}
    end

    # waits until some condition is true and
    # returns false if timeout occurred, true otherwise
    #
    # examples:
    #   wait_until {text_field(:name => 'x').exists?} # waits until text field exists
    #   wait_until(5) {...} # waits maximum of 5 seconds condition to be true
    def wait_until *arg
      begin
        wait_until!(*arg) {yield}
      rescue Watir::Exception::TimeOutException
        return false
      end

      return true
    end

    # returns WatiRspec::HtmlFormatter object, nil if not in use
    def formatter
      @formatter ||= Spec::Runner.options.formatters.find {|f| f.kind_of?(WatiRspec::HtmlFormatter) rescue false}
    end

    # returns unique file path for use in examples.
    #
    # all file names generated with this method will
    # be shown on the report upon test failure.
    def file_path(file_name, description=nil)
      formatter.file_path(file_name, description)
    rescue
      extension = File.extname(file_name)
      basename = File.basename(file_name, extension)
      file_path = File.join(Dir.pwd, "#{basename}_#{Time.now.strftime("%H%M%S")}#{extension}")
      file_path
    end

    # returns native file path
    # e.g. on Windows:
    #   native_file_path("c:/blah/blah2/file.txt") => c:\\blah\\blah2\\file.txt 
    def native_file_path(file_path)
      File::ALT_SEPARATOR ? file_path.gsub(File::SEPARATOR, File::ALT_SEPARATOR) : file_path
    end

  end
end