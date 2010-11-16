module WatirSplash
  # class for common functionality
  class Util
    class << self

      # loads ui-test-common/environment.rb
      #
      # ui-test-common has to be located at some higher level within directory
      # structure compared to project/ui-test directory
      def load_common
        dir = common_dir
        puts "Loading ui-test-common from #{dir}..."
        require File.join(dir, "environment.rb")
      end

      # loads environment.rb for the project if it exists in the ui-test
      # or in some higher level directory 
      def load_environment
        Pathname(Dir.pwd).ascend do |path|
          require File.join(path, "environment.rb") if has_environment?(path)
        end
      end

      # configure RSpec to use documentation and WatirSplash::HtmlFormatter formatters
      def configure_rspec_formatters
        config = RSpec.configuration
        config.color_enabled = true
        documentation_formatter = config.send(:built_in_formatter, :documentation).new(config.output)
        results_path = ENV["WATIRSPLASH_RESULTS_PATH"] || "results/index.html"
        @@html_formatter = WatirSplash::HtmlFormatter.new(results_path)
        config.instance_variable_set(:@reporter, RSpec::Core::Reporter.new(documentation_formatter, @@html_formatter))
      end

      def formatter
        @@html_formatter
      end

      private

      def common_dir
        ui_test_common_dir = "ui-test-common"
        Pathname(Dir.pwd).ascend do |path|
          if File.exists?(dir = File.join(path, ui_test_common_dir)) &&
                  has_environment?(dir)
            return dir
          end
        end
        raise "#{ui_test_common_dir} directory was not found! It has to exist somewhere higher in directory tree than your project's directory and it has to have environment.rb file in it!"
      end

      def has_environment? dir
        return File.exists?(File.join(dir, "environment.rb"))
      end

    end
  end
end