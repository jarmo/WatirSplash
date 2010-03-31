Spec::Runner.configure do |config|
  config.include(WatiRspec::SpecHelper)

  config.before(:all) do
    open_browser_at "about:blank"
  end

  config.after(:all) do
    close
  end
end

class Spec::ExampleGroup
  subject {self}
end