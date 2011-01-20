require "pathname"

module WatirSplash
  module Generators
    class MigrateProject < Thor::Group
      include Thor::Actions

      argument :dir

      def self.source_root
        File.dirname(__FILE__) + "/templates"
      end

      def migrate
        gsub_file("config.rb", /^(\s*)Spec::Runner\./, "\\1RSpec.")

        if File.basename(Dir.pwd) == "ui-test"
          remove_file "spec/spec.opts"
          template "new_project/.rspec", ".rspec"
        end
      end

    end
  end
end
