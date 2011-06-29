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
          Util.formatter.browser = @browser 
        else
          @browser = WatirSplash::Browser.new
          @browser.goto @@url
        end
      end

      def return_for element, methodz
        methodz.each_pair do |meth, return_value|
          element.instance_eval do 
            instance_variable_set("@#{meth}_return_value", return_value)
            instance_eval %Q[
              self.class.send(:alias_method, :__#{meth}, :#{meth}) if respond_to? :#{meth}

              def #{meth}(*args)
                self.send(:__#{meth}, *args) if respond_to? :__#{meth}
                instance_variable_get("@#{meth}_return_value").call(*args)
              end
            ]
          end
        end
        element
      end
    end
  end
end
