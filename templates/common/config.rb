=begin
  Global configuration constants
  For example, you can use the URL constant below from your projects like this:

  In your projects' config.rb:

  module Config
    module Application
      URL = Config.full_url("my_subpage/index.html") # => equals "http://localhost/my_subpage/index.html
    end
  end
=end

require "uri"

module Config
  module GlobalApplication
    URL = "http://localhost"
  end

  def Config.full_url relative_url
    URI.join(GlobalApplication::URL, relative_url).to_s
  end
end

Spec::Runner.configure do |config|
  config.include(CommonApplicationHelper)
end