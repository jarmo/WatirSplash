WatirSplash::Frameworks::Helper.load_gem :gem => "watir-webdriver", :version => ">=0.2.0"

module Watir
  class Browser
    def save_screenshot(params)
      driver.save_screenshot(params[:file_name])
    end
  end
end

