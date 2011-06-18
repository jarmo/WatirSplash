WatirSplash::Frameworks::Helper.load_gem "watir-webdriver"

module Watir
  class Browser
    def save_screenshot(params)
      driver.save_screenshot(params[:file_name])
    end
  end
end

