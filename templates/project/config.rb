# Config for your application
module Config
  module Application
    # URL, which will be opened by every test
    # replace it with the URL of your application under test
    URL = "about:blank"
  end
end

# A global configuration for specs, which will include by default
# a ApplicationHelper module and open Config::Application::URL with
# the browser.
# You can read more about RSpec-s before and after syntax from:
# http://rspec.info/documentation/before_and_after.html
Spec::Runner.configure do |config|
  config.include(ApplicationHelper)
  config.before(:all) {goto Config::Application::URL}
end