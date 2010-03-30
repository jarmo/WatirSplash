Spec::Runner.configure do |config|
  config.include(WatiRspec::SpecHelper)

  config.before(:all) do
    url = Config::Application::URL rescue "about:blank"
    open_browser_at url
    @autoit = Watir.autoit
  end

  config.after(:all) do
    @browser.close
  end
end

class Spec::ExampleGroup
  subject {self}
end