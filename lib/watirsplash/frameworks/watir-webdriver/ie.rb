require_rel "../watir-webdriver.rb"
WatirSplash::Frameworks::Helper.load_gem :gem => "win32screenshot", :require => "win32/screenshot"

module WatirSplash
  class Browser
    def self.new
      Watir::Browser.new :ie
    end
  end
end

module Watir
  class Browser
    def save_screenshot(params)
      ::Win32::Screenshot::Take.of(:window, :title => title).write(params[:file_name])
    rescue => e
      $stderr.puts "saving of screenshot failed: #{e.message}"
    end
  end
end
