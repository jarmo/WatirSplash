module WatirSplash
  module Generators
    class NewCommonProject < Thor::Group
      include Thor::Actions
      include Helper

      argument :url 
      argument :framework

      def self.source_root
        File.dirname(__FILE__) + "/templates"
      end

      def generate
        directory("new_common_project", File.basename(Dir.pwd) == "ui-test-common" ? "." : "ui-test-common")
      end

    end
  end
end
