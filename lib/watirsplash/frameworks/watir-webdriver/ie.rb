require_rel "../watir-webdriver.rb"
WatirSplash::Frameworks::Helper.load_gem :gem => "win32screenshot", :require => "win32/screenshot"

module WatirSplash
  class Browser
    def self.new
      Watir::Browser.new :ie
    end
  end
end
