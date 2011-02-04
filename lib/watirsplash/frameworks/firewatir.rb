begin
  gem "firewatir", "1.7.1"
  require "firewatir"
rescue Gem::LoadError
  puts "Unable to load FireWatir gem. Install it with 'gem install firewatir -v 1.7.1'"
  exit 1
end

module FireWatir #:nodoc:all
  class Firefox
    def exists?
      js_eval("getWindows().length").to_i == 1 || find_window(:url, @window_url) > 0
    end

    alias_method :exist?, :exists?
  end
end
