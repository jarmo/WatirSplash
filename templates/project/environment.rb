# add all your require statements into this file to avoid unnecessary
# code in your spec files

# by default everything, which is not a spec file, will be loaded
local_dir = File.join(File.dirname(__FILE__), "**/*.rb")
filtered_ruby_files = Dir.glob(local_dir).delete_if do |file|
  File.directory?(file) || File.basename(file) =~ /(ide_runner|config|_spec)\.rb$/
end
require_all filtered_ruby_files
require_rel "config.rb"