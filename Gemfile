source :rubygems

# load WatirSplash and it's dependencies
gemspec

platforms :mingw, :mswin do
    gem "watir", WatirSplash::Version::WATIR
    gem "win32screenshot", WatirSplash::Version::WIN32SCREENSHOT, :require => "win32/screenshot"
end

gem "watir-webdriver", WatirSplash::Version::WATIR_WEBDRIVER
gem "firewatir", ">= 1.9.4"
gem "rspec", "~>2.6.0"
gem "spork", "~>0.9.0.rc9"
gem "spork-local_process"

# add your project specific dependencies here:
# gem "ruby-debug", "0.10.3"
