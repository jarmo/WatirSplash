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
            instance_variable_set("@_#{meth}_return_value_proc", return_value)
            instance_eval %Q[
              self.class.send(:alias_method, :__#{meth}, :#{meth}) if respond_to? :#{meth}

              def #{meth}(*args)
                self.send(:__#{meth}, *args) if respond_to? :__#{meth}
                instance_variable_get("@_#{meth}_return_value_proc").call(*args)
              end
            ]
          end
        end
        element
      end
    end
  end
end
