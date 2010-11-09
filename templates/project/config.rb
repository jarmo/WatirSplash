# Config for your application
module Config
  module Application
    # URL, which will be opened by every test
    #
    # Replace it with the URL of your application under test
    # or if ui-test-common is used then
    # URL = Config.full_url("/relative/url/index.html")
    URL = "about:blank"
  end
end

# A global configuration for specs in this project, which will include by default
# a ApplicationHelper module and open Config::Application::URL with
# the browser.
#
# You can read more about RSpec-s before and after syntax from:
# http://rspec.info/documentation/before_and_after.html
RSpec.configure do |config|
  config.include(ApplicationHelper)
  config.before(:all) {goto Config::Application::URL}
end