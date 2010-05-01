module WatirSplash

  # WatirSplash Generator class is responsible for:
  # * generating directory structures for projects
  class Generator
    @@template_directory = File.join(File.dirname(__FILE__), "../../templates/")

    class << self

      # Generates ui-test directory structure for project
      def generate
        ui_test_dir = File.join(Dir.pwd, "ui-test")
        puts "Creating WatirSplash directory structure to #{ui_test_dir}..."
        require "fileutils"
        FileUtils.cp_r File.join(@@template_directory, "project/."), ui_test_dir
        puts "Done"
        return 0
      rescue => e
        puts "Failed:"
        puts e.message
        return -1
      end

      # Generates ui-test-common directory structure
      def generate_common
        common_dir = File.join(Dir.pwd, "ui-test-common")
        puts "Creating WatirSplash ui-test-common directory structure to #{common_dir}..."
        require "fileutils"
        FileUtils.cp_r File.join(@@template_directory, "common/."), common_dir
        puts "Done"
        return 0
      rescue => e
        puts "Failed:"
        puts e.message
        return -1
      end

      # Shows help
      def help
        puts %Q{WatirSplash:
Usage: watirsplash (COMMAND|FILE(:LINE)?|DIRECTORY|GLOB)+ [options]
Commands:
          * generate - generate default directory structure for new project
          * generate_common - generate common project directory structure
          * help - show this help
          * --help - show RSpec's help

All other commands/options will be passed to RSpec directly.}

        return 1
      end

    end
  end
end
