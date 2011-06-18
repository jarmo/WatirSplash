WatirSplash::Frameworks::Helper.load_gem :gem => "firewatir",
  :version => WatirSplash::Version::WATIR

module FireWatir #:nodoc:all
  class Firefox
    def save_screenshot(params)
      # currently not yet supported
    end
  end
end
