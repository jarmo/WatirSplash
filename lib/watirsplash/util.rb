module WatirSplash
  # class for common functionality
  class Util
    class << self
      # returns unique file path for use in the examples
      #
      # all file names generated with this method will
      # be shown on the report upon test failure.
      def file_path(file_name, description=nil)
        WatirSplash::Util.formatter.file_path(file_name, description)
      end

      # returns native file path
      # e.g. on Windows:
      #   file_native_path("c:/blah/blah2/file.txt") => c:\\blah\\blah2\\file.txt
      def file_native_path(file_path)
        File::ALT_SEPARATOR ? file_path.gsub(File::SEPARATOR, File::ALT_SEPARATOR) : file_path
      end

      def formatter
        @html_formatter ||= begin
                              formatter = RSpec.configuration.formatters.find {|formatter| formatter.kind_of? WatirSplash::HtmlFormatter}
                              raise "WatirSplash::HtmlFormatter is not loaded - are you sure that you have specified it in your .rspec file?" unless formatter
                              formatter
                            end
      end

      def framework= framework
        framework = framework.to_sym
        @framework = framework == :default ? default_framework : framework
      end

      def framework
        @framework
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
