module WatirSplash
  class Browser
    def self.new
      browser = Watir::Browser.new
      Util.formatter.browser = browser
      browser
    end    
  end
end

