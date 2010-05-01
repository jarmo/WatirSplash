module WatirSplash

  # WatirSplash runner class is responsible for:
  # * generating directory structures for projects
  # * starting RSpec with specified settings
  class Runner
    @@template_directory = File.join(File.dirname(__FILE__), "../../templates/")

    class << self

      # Run RSpec with custom settings
      # * loads spec.opts from project's directory if exists
      # * loads environment.rb from project's directory if exists
      # * loads custom Formatter
      def run
        unless ARGV.empty?
          require "watirsplash"
          load_formatter
          load_options
          load_project_env
        else
          return help
        end

        ::Spec::Runner::CommandLine.run
      end

      # Generates ui-test project structure for project
      def generate
        ui_test_dir = File.join(Dir.pwd, "ui-test")
        puts "Creating WatirSplash project directory structure to #{ui_test_dir}..."
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
        puts "Creating WatirSplash common project directory structure to #{common_dir}..."
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

      private

      def load_formatter
        ARGV << "--require" << "watirsplash/html_formatter.rb"
        ARGV << "--format" << "WatirSplash::HtmlFormatter:#{File.join(Dir.pwd, "results/index.html")}"
      end

      def load_options
        ARGV << "--options"
        project_spec_opts = File.join(Dir.pwd, "spec.opts")
        if File.exists?(project_spec_opts)
          ARGV << project_spec_opts
        else
          ARGV << "#{File.join(File.dirname(__FILE__), "../spec.opts")}"
        end
      end

      def load_project_env
        project_env_file = File.join(Dir.pwd, "environment.rb")
        if File.exists?(project_env_file)
          ARGV << "--require" << project_env_file
        end
      end

    end
  end
end
