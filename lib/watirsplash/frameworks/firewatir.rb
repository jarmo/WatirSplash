supported_version = "1.7.1"

begin
  gem "firewatir", supported_version
  require "firewatir"
rescue Gem::LoadError
  puts "Unable to load FireWatir gem. Install it with:\ngem install firewatir -v #{supported_version}"
  exit 1
end

module FireWatir #:nodoc:all
  class Firefox
    def exists?
      js_eval("getWindows().length").to_i == 1 || find_window(:url, @window_url) > 0
    end

    alias_method :exist?, :exists?

    def save_screenshot(params)
      # currently not yet supported
    end
  end
end
