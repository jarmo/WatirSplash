WatirSplash::Frameworks::Helper.load_gem :gem => "watir-webdriver",
  :version => WatirSplash::Version::WATIR_WEBDRIVER

module Watir
  class Browser
    def save_screenshot(params)
      driver.save_screenshot(params[:file_name])
    end
  end
end

