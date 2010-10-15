require "rubygems"
require "require_all"
require "rautomation"
# initialize explicitly RAutomation::Window object to load correct version of AutoIt
RAutomation::Window.new(:title => "sometitle")

gem "rspec", "=1.3.0"
require "spec"
gem "watir", "=1.6.6"
require "watir"
require "pathname"
require_rel "watirsplash/wait_helper"
require_rel "watirsplash/element_extensions"
require_rel "watirsplash/file_helper"
require_rel "watirsplash/spec_helper"
require_rel "watirsplash/spec"
require_rel "watirsplash/watir"
require_rel "watirsplash/util"
WatirSplash::Util.load_environment

