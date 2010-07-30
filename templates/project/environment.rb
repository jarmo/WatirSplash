# Add all your require statements into this file to avoid unnecessary
# code in your spec files

# Uncomment following line to load functionality from ui-test-common
# WatirSplash::Util.load_common

# By default everything, which is not a spec file, will be loaded from spec directory
# and it's subdirectories
spec_dir = File.join(File.dirname(__FILE__), "spec/**/*.rb")
filtered_ruby_files = Dir.glob(spec_dir).delete_if do |file|
  File.basename(file) =~ /.*_spec\.rb$/
end
require_all filtered_ruby_files unless filtered_ruby_files.empty?
require_rel "config.rb"