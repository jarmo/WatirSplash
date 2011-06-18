module WatirSplash
  module Generators
    module Helper
      def supported_frameworks
        %w[default watir firewatir watir-webdriver/ie watir-webdriver/firefox watir-webdriver/chrome]
      end

      def frameworks_banner
        "# What framework to use? Possible values are:\r\n" +
          "#   * #{supported_frameworks.join("\r\n#   * ")}\r\n" +
          "WatirSplash::Util.framework = \"#{framework}\""
      end
    end
  end
end
