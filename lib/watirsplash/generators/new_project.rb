require "uri"

module WatirSplash
  module Generators
    class NewProject < Thor::Group
      include Thor::Actions
      include Helper

      argument :name 
      argument :url
      argument :framework
      argument :load_common, :optional => true

      def self.source_root
        File.dirname(__FILE__) + "/templates"
      end

      def generate
        dest = File.basename(Dir.pwd) == "ui-test" ? "." : "ui-test"
        directory("new_project", dest)
        template("../../../../Gemfile", "#{dest}/Gemfile")
        
        require "watirsplash/version"
        gsub_file("#{dest}/Gemfile", "gemspec", "")
        gsub_file("#{dest}/Gemfile", /WatirSplash::Version::WATIRSPLASH.*/, "\"#{WatirSplash::Version::WATIRSPLASH}\"")
        gsub_file("#{dest}/Gemfile", /WatirSplash::Version::WATIR_WEBDRIVER/, "\"#{WatirSplash::Version::WATIR_WEBDRIVER}\"")
        gsub_file("#{dest}/Gemfile", /WatirSplash::Version::WATIR/, "\"#{WatirSplash::Version::WATIR}\"")
        gsub_file("#{dest}/Gemfile", /WatirSplash::Version::WIN32SCREENSHOT/, "\"#{WatirSplash::Version::WIN32SCREENSHOT}\"")
      end

      def load_common_cmd
        cmd = ""
        cmd = "# Uncomment the following line to load functionality from ui-test-common\r\n# " unless load_common
        cmd += "WatirSplash::Util.load_common"
        cmd
      end

      def formatted_name
        Thor::Util.snake_case(name)
      end

      def formatted_url
        uri = URI.parse(url)
        if load_common && !default_url? && uri.relative?
          %Q[Config.full_url("#{uri}")] 
        else
          %Q["#{uri}"]
        end
      end

      def default_url?
        url.to_s == "about:blank"
      end

    end
  end
end
