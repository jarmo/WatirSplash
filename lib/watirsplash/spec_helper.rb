module WatirSplash
  # main helper module
  #
  # these methods can be used in specs directly
  module SpecHelper

    # opens the browser at specified url
    def open_browser_at url
      @browser = WatirSplash::Util.browser
      Util.formatter.browser = @browser 
      goto url
    end
    
    def method_missing name, *args #:nodoc:
      @browser.respond_to?(name) ? @browser.send(name, *args) {yield} : super
    end

    # make sure that using method 'p' will be invoked on @browser
    # and not Kernel
    # use Kernel.p if you need to dump some variable 
    def p *args #:nodoc:
      @browser.p *args
    end

  end
end
