module WatiRspec
  module SpecHelper

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

    def download_file file_name
      AutoItHelper.click_save
      file_path = formatter.native_file_path(file_name)
      AutoItHelper.set_edit(file_path)
      AutoItHelper.click_save("Save As")
      wait_until! {File.exists?(file_path)}
      file_path
    end

    def method_missing name, *arg
      @browser.respond_to?(name) ? @browser.send(name, *arg) : super
    end

    def wait_until! *arg
      Watir::Waiter.wait_until(*arg) {yield}
    end

    def wait_until *arg
      begin
        wait_until!(*arg) {yield}
      rescue Watir::Exception::TimeOutException
        return false
      end

      return true
    end

    def formatter
      @formatter ||= Spec::Runner.options.formatters.find {|f| f.kind_of?(WatiRspec::HtmlFormatter) rescue false}
    end

    def file_path(file_name, description=nil)
      formatter.file_path(file_name, description)
    end
  end
end