require "rubygems"
require "bundler"
Bundler.setup

require File.dirname(__FILE__) + "/../lib/watirsplash"
WatirSplash::Util.framework = "default"
WatirSplash::Util.load_framework

RSpec.configure do |config|
  config.before(:all) do
    WatirSplash::Browser.new
  end

  config.after(:all) do
    WatirSplash::Browser.current.close
  end
end

