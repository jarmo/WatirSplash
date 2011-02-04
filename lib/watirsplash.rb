require "rubygems"
require "require_all"
require "rautomation"
require "rspec"
require "pathname"
require_rel "watirsplash/browser"
require_rel "watirsplash/file_helper"
require_rel "watirsplash/spec_helper"
require_rel "watirsplash/rspec_patches"
require_rel "watirsplash/util"
require_rel "watirsplash/html_formatter"
WatirSplash::Util.configure_rspec_formatters
WatirSplash::Util.load_environment
WatirSplash::Util.load_framework

