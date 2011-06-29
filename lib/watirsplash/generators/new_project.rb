require "uri"
require "watirsplash/version"

module WatirSplash
  module Generators
    class NewProject < Thor::Group
      include Thor::Actions
      include Helper

      argument :name 
      argument :url
      argument :framework

      def self.source_root
        File.dirname(__FILE__) + "/templates"
      end

      def generate
        directory("new_project", name)
        template("../../../../Gemfile", "#{name}/Gemfile")
        
        gsub_file("#{name}/Gemfile", "gemspec", %Q{gem "watirsplash", "#{WatirSplash::Version::WATIRSPLASH}"})
        gsub_file("#{name}/Gemfile", /WatirSplash::Version::WATIR_WEBDRIVER/, "\"#{WatirSplash::Version::WATIR_WEBDRIVER}\"")
        gsub_file("#{name}/Gemfile", /WatirSplash::Version::WATIR/, "\"#{WatirSplash::Version::WATIR}\"")
        gsub_file("#{name}/Gemfile", /WatirSplash::Version::WIN32SCREENSHOT/, "\"#{WatirSplash::Version::WIN32SCREENSHOT}\"")
      end

      def formatted_url
        uri = URI.parse(url)
        if !default_url? && uri.relative?
          %Q[Config.full_url("#{uri}")] 
        else
          %Q["#{uri}"]
        end
      end

      def formatted_name
        name
      end

      def default_url?
        url.to_s == "about:blank"
      end

    end
  end
end
