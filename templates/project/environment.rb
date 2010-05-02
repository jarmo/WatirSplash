# Add all your require statements into this file to avoid unnecessary
# code in your spec files

# Uncomment following line to load functionality from ui-test-common
# WatirSplash::Util.load_common

# By default everything, which is not a spec file, will be loaded from spec directory
# and it's subdirectories
spec_dir = File.join(File.dirname(__FILE__), "spec/**/*.rb")
filtered_spec_files = Dir.glob(spec_dir).delete_if do |file|
  File.directory?(file) || File.basename(file) =~ /.*spec\.rb$/
end
require_rel filtered_spec_files
require_rel "config.rb"
require_rel "application_helper.rb"