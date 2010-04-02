Spec::Runner.configure do |config| #:nodoc:
  config.include(WatiRspec::SpecHelper)

  config.before(:all) do
    open_browser_at "about:blank"
  end

  config.after(:all) do
    close
  end
end

module Spec #:nodoc:all
  class ExampleGroup
    subject {self}
  end
end