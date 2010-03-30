require "watirspec/spec_helper"

module WatiRspec
  class Runner
    class << self
      def run
        ARGV << "--require" << "watirspec/html_formatter.rb"
        ARGV << "--format" << "WatiRspec::HtmlFormatter:#{File.join(Dir.pwd, "results/index.html")}"
        ::Spec::Runner::CommandLine.run
      end
    end
  end
end
