source :rubygems

# load WatirSplash and it's dependencies
gem "watirsplash", "1.5.0" unless File.exists?("watirsplash.gemspec")

platforms :mingw, :mswin do
    gem "watir", "1.9.0"
    gem "win32screenshot", "1.0.4", :require => "win32/screenshot"
end

gem "watir-webdriver", "0.2.4"
gem "firewatir", "1.9.0"
gem "rake", "0.8.7"

gemspec if File.exists?("watirsplash.gemspec")

# add your project specific dependencies here
