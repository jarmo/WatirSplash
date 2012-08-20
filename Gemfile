source :rubygems 
# load WatirSplash and it's dependencies
gemspec

platforms :mingw, :mswin do
  gem "watir", WatirSplash::Version::WATIR
end

gem "watir-webdriver", WatirSplash::Version::WATIR_WEBDRIVER
gem "rspec", "~>2.9.0"
gem "spork", "~>0.9.0"
gem "spork-local_process", "~> 0.0.7"

# add your project specific dependencies here:
platforms :mri_18, :ruby_18, :mingw_18 do
  # gem "ruby-debug", "0.10.3"
end

platforms :mri_19, :ruby_19, :mingw_19 do
  # gem "ruby-debug19"
end
