require "uri"

module WatirSplash
  module Generators
    class Page < Thor::Group
      include Thor::Actions
      #include Helper

      argument :app_name 
      argument :page_name
      argument :url, :optional => true

      def self.source_root
        File.dirname(__FILE__) + "/templates"
      end

      def generate
        dest = File.basename(Dir.pwd) == "ui-test" ? "./lib" : "ui-test/lib"
        directory("page", dest)
      end

      def formatted_name
        Thor::Util.snake_case(app_name)
      end

      def formatted_url
        uri = URI.parse(url)
        if load_common && !default_url? && uri.relative?
          %Q[Config.full_url("#{uri}")] 
        else
          %Q["#{uri}"]
        end
      end
    end
  end
end
