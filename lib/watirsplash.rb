require "rubygems"
require "require_all"
require "rspec"
require "pathname"
require_rel "watirsplash/browser"
require_rel "watirsplash/file_helper"
require_rel "watirsplash/spec_helper"
require_rel "watirsplash/rspec_patches"
require_rel "watirsplash/util"
require_rel "watirsplash/html_formatter"
require_rel "watirsplash/frameworks/helper"
WatirSplash::Util.configure_rspec_formatters

