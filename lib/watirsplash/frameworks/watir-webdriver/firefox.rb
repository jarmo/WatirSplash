require_rel "../watir-webdriver.rb"

module WatirSplash
  class Browser
    def self.new
      prepare Watir::Browser.new(:firefox)
    end
  end
end
