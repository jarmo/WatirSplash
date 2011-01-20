module WatirSplash
  module Generators
    class NewCommonProject < Thor::Group
      include Thor::Actions

      argument :url, :desc => "url for the application main page", :default => "http://localhost"

      def self.source_root
        File.dirname(__FILE__) + "/templates"
      end

      def generate
        directory("new_common_project", "ui-test-common")
      end

    end
  end
end
