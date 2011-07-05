module WatirSplash
  class Browser
    class << self
      def new
        prepare Watir::Browser.new
      end    

      @@current = nil

      def current
        @@current
      end

      def current= browser
        @@current = browser
      end

      private

      def prepare browser
        self.current = browser
        browser
      end

    end
  end
end

