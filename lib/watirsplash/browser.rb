module WatirSplash
  class Browser
    class << self

      attr_accessor :current

      def new
        prepare Watir::Browser.new
      end    

      private

      def prepare browser
        self.current = browser
        browser
      end

    end
  end
end

