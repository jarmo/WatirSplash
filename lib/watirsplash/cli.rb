require "thor"
require "thor/group"
require "watirsplash/generators/helper"
require "watirsplash/generators/new_project"
require "watirsplash/generators/migrate_project"
require "watirsplash/generators/page"
require "watirsplash/util"

module WatirSplash
  class CLI < Thor
    extend Generators::Helper

    framework_option = proc do
      method_option :framework, :default => "default", :aliases => "-f",
        :desc => "Framework to use. Possible values are #{supported_frameworks.join(", ")}."
    end

    desc "new [DIRECTORY_NAME]", "Create a new WatirSplash project."
    method_option :url, :default => "about:blank", :aliases => "-u",
      :desc => "URL to open in the browser before each test. May be relative if WatirSplash common project is loaded."
    framework_option.call
    def new(name = "ui-test")
      WatirSplash::Generators::NewProject.start([Thor::Util.camel_case(name), options[:url], options[:framework], options.load_common?])
    end

    desc "page PAGE_NAME [element_name:element_type:locator_name:locator_value]", "Create a new WatirSplash page."
    method_option :url, :default => nil, :aliases => "-u",
      :desc => "URL for the page if directly accessible."
    def page(page_name = "Main", *elements)
      WatirSplash::Generators::Page.start([Thor::Util.camel_case(page_name), elements, options[:url]])
    end

    if File.basename(Dir.pwd) =~ /^ui-test(-common)?$/
      desc "migrate", "Migrate old WatirSplash (version < 1.0) generated project to new."
      def migrate
        WatirSplash::Generators::MigrateProject.start
      end
    end

  end  
end
