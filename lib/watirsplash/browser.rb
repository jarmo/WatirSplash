module WatirSplash
  class JavaScriptError < RuntimeError; end

  class Browser
    # raises an error if any JavaScript errors were found
    JAVASCRIPT_ERRORS_CHECKER = lambda do |browser| 
      error_message = browser.execute_script "#{browser.respond_to?(:driver) ? "return ": nil}window.__browserErrorMessage"

      if error_message && !error_message.empty?
        browser.execute_script "window.__browserErrorMessage = undefined"
        raise JavaScriptError, "JavaScript error: #{error_message}"
      end
      
      browser.execute_script %q[
        if (!window.onErrorFn) {
          window.onErrorFn = function(errorMsg, url, lineNumber) {
                               window.__browserErrorMessage = errorMsg + " @ " + url + ":" + lineNumber;

                               if (window.__onErrorFn)
                                 window.__onErrorFn(errorMsg, url, lineNumber);

                               return false;
                             };

          window.__onErrorFn = window.onerror;
          window.onerror = window.onErrorFn;
        }]
    end
          
    class << self

      attr_accessor :current

      def new
        prepare Watir::Browser.new
      end    

      private

      def prepare browser
        self.current = browser
        browser.add_checker JAVASCRIPT_ERRORS_CHECKER
        browser
      end

    end
  end
end

