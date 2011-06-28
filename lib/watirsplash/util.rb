module WatirSplash
  # class for common functionality
  class Util
    class << self

      # configure RSpec to use documentation and WatirSplash::HtmlFormatter formatters
      def configure_rspec_formatters
        config = RSpec.configuration
        config.color_enabled = true
        results_path = ENV["WATIRSPLASH_RESULTS_PATH"] || "results/index.html"
        @@html_formatter = WatirSplash::HtmlFormatter.new(results_path)
        config.formatters.unshift(@@html_formatter)
        config.add_formatter(:documentation)
      end

      def formatter
        @@html_formatter
      end

      @@framework = nil

      def framework= framework
        framework = framework.to_sym
        @@framework = framework == :default ? default_framework : framework.to_sym
      end

      def framework
        @@framework
      end

      def load_framework
        self.framework = ENV["WATIRSPLASH_FRAMEWORK"] || framework || default_framework
        require "watirsplash/frameworks/#{framework}"
      end

      private

      def default_framework
        case RUBY_PLATFORM
        when /mswin|msys|mingw32/
          :watir
        when /darwin|linux/
          :firewatir
        else
          raise "Unsupported platform: #{RUBY_PLATFORM}"
        end
      end

    end
  end
end
