require "rubygems"
require "require_all"
require "rautomation"
require "rspec"
require "watir"
require "pathname"
require_rel "watirsplash/file_helper"
require_rel "watirsplash/spec_helper"
require_rel "watirsplash/rspec_patches"
require_rel "watirsplash/util"
require_rel "watirsplash/html_formatter"
require_rel "watirsplash/framework_loaders"
WatirSplash::Util.configure_rspec_formatters
WatirSplash::Util.load_environment

