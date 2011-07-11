require 'rubygems'
require "bundler"
Bundler.setup
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  require "watirsplash"

  # What framework to use? Possible values are:
  #   * default
  #   * watir
  #   * firewatir
  #   * watir-webdriver/ie
  #   * watir-webdriver/firefox
  #   * watir-webdriver/chrome
  WatirSplash::Util.framework = "default"

  # Load the framework specified by the environment variable WATIRSPLASH_FRAMEWORK or WatirSplash::Util.framework
  WatirSplash::Util.load_framework

  require_rel "../config.rb"

  # Add all your require statements into this block to avoid unnecessary
  # code in your spec files
end

Spork.each_run do
  # Save WatirSplash html spec results to the specified directory. If
  # output_stream exists then Spork is not running.
  ENV["WATIRSPLASH_RESULTS_PATH"] ||= RSpec.configuration.settings[:output_stream] ?
    "results/local/index.html" :
    "results/#{Time.now.strftime("%y%m%d_%H%M%S")}/index.html"

  # This code will be run each time you run your specs.
  require_all Dir.glob(File.join(File.dirname(__FILE__), "../lib/**/*.rb"))
end

# --- Instructions ---
# Sort the contents of this file into a Spork.prefork and a Spork.each_run
# block.
#
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
#
# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
#
# Note: You can modify files loaded *from* the Spork.each_run block without
# restarting the spork server.  However, this file itself will not be reloaded,
# so if you change any of the code inside the each_run block, you still need to
# restart the server.  In general, if you have non-trivial code in this file,
# it's advisable to move it into a separate file so you can easily edit it
# without restarting spork.  (For example, with RSpec, you could move
# non-trivial code into a file spec/support/my_helper.rb, making sure that the
# spec/support/* files are require'd from inside the each_run block.)
#
# Any code that is left outside the two blocks will be run during preforking
# *and* during each_run -- that's probably not what you want.
#
# These instructions should self-destruct in 10 seconds.  If they don't, feel
# free to delete them.
