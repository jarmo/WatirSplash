require_rel "../watir-webdriver.rb"

module WatirSplash
  class Browser
    def self.new
      browser = Watir::Browser.new :firefox
      Util.formatter.browser = browser
      browser
    end
  end
end
