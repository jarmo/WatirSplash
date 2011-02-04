supported_version = "0.1.9"

begin
  gem "watir-webdriver", supported_version 
  require "watir-webdriver"
rescue Gem::LoadError
  puts "Unable to load Watir-WebDriver gem. Install it with:\ngem install watir-webdriver -v #{supported_version}"
  exit 1
end

module Watir
  class Browser
    alias_method :exists?, :exist?

    def save_screenshot(params)
      driver.save_screenshot(params[:file_name])
    end
  end
end

module WatirSplash
  class Browser
    def self.new
      Watir::Browser.new :firefox
    end
  end
end
