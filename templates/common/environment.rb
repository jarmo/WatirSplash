=begin
  You have to load this file from your projects' environment.rb, which
  would like to use common functionality.

  Use the following code to do it automatically:
  WatirSplash::Util.load_common

  Add all your require statements into this file to avoid unnecessary
  code in your other projects' files

  By default everything in lib directory will be loaded
=end

require_rel "lib/"
require_rel "config.rb"
