module WatirSplash
  # main helper module
  #
  # these methods can be used in specs directly
  module SpecHelper
    include Watir::WaitHelper

    # opens the browser at specified url
    def open_browser_at url
      @browser = Watir::Browser.new
      @browser.speed = :fast
      add_checker Watir::PageCheckers::JAVASCRIPT_ERRORS_CHECKER
      formatter.browser = @browser rescue nil 
      goto url
      maximize
    end

    # returns WatirSplash::HtmlFormatter object, nil if not in use
    def formatter
      @formatter ||= Spec::Runner.options.formatters.find {|f| f.kind_of?(WatirSplash::HtmlFormatter) rescue false}
    end

    module_function :formatter

    def method_missing name, *args #:nodoc:
      @browser.respond_to?(name) ? @browser.send(name, *args) : super
    end

    # make sure that using method 'p' will be invoked on @browser
    # and not Kernel
    # use Kernel.p if you need to dump some variable 
    def p *args #:nodoc:
      @browser.p *args
    end

  end
end