WatirSplash::Frameworks::Helper.load_gem :gem => "watir-webdriver", :version => "0.1.9"

module Watir
  class Browser
    alias_method :exists?, :exist?

    def save_screenshot(params)
      driver.save_screenshot(params[:file_name])
    end
  end
end

