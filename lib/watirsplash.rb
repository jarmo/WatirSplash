require "rubygems"
require "require_all"
require "rautomation"
# initialize explicitly RAutomation::Window object to load correct version of AutoIt
RAutomation::Window.new(:title => "sometitle")
require "spec"
require "watir"
require "pathname"
require_rel "watirsplash/file_helper"
require_rel "watirsplash/spec_helper"
require_rel "watirsplash/rspec_patches"
require_rel "watirsplash/watir_patches"
require_rel "watirsplash/util"
WatirSplash::Util.load_environment

