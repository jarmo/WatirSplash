source :rubygems

# load WatirSplash and it's dependencies
gemspec
gem "watirsplash", WatirSplash::Version::WATIRSPLASH unless File.exists?("watirsplash.gemspec")

platforms :mingw, :mswin do
    gem "watir", WatirSplash::Version::WATIR
    gem "win32screenshot", WatirSplash::Version::WIN32SCREENSHOT, :require => "win32/screenshot"
end

gem "watir-webdriver", WatirSplash::Version::WATIR_WEBDRIVER
gem "firewatir", WatirSplash::Version::WATIR

# add your project specific dependencies here
