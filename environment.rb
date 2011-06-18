require "rubygems"
require "bundler"
Bundler.setup

require File.dirname(__FILE__) + "/lib/watirsplash"
WatirSplash::Util.framework = "default"
WatirSplash::Util.load_framework

