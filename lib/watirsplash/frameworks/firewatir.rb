WatirSplash::Frameworks::Helper.load_gem :gem => "firewatir", :version => "1.7.1"

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
