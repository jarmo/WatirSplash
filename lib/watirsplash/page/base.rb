module WatirSplash
  module Page
    class Base
      include SpecHelper

      class << self
        @@url = "about:blank"

        def url url
          @@url = url
        end

      end

      def initialize(browser=nil)
        if browser
          @browser = browser 
        else
          @browser = WatirSplash::Browser.exists? ? WatirSplash::Browser.current : (WatirSplash::Browser.current = WatirSplash::Browser.new)
          @browser.goto @@url
        end
      end

      def redirect_to page, browser=nil
        page.new browser || WatirSplash::Browser.current
      end      

      def modify element, methodz
        methodz.each_pair do |meth, return_value|
          element.instance_eval do 
            singleton = class << self; self end

            singleton.send :alias_method, "__#{meth}", meth if respond_to? meth
            singleton.send :define_method, meth do |*args|
              self.send("__#{meth}", *args) if respond_to? "__#{meth}"
              return_value.call(*args)
            end
          end
        end
        element
      end
    end
  end
end
