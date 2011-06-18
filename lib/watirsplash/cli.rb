require "thor"
require "thor/group"
require "watirsplash/generators/helper"
require "watirsplash/generators/new_project"
require "watirsplash/generators/new_common_project"
require "watirsplash/generators/migrate_project"
require "watirsplash/util"

module WatirSplash
  class CLI < Thor
    extend Generators::Helper

    framework_option = proc do
      method_option :framework, :default => "default", :aliases => "-f",
        :desc => "Framework to use. Possible values are #{supported_frameworks.join(", ")}."
    end

    desc "new [APPLICATION_NAME]", "Create a new WatirSplash project."
    method_option :load_common, :type => :boolean, :default => false, :aliases => "-l",
      :desc => "Load WatirSplash common project automatically."
    method_option :url, :default => "about:blank", :aliases => "-u",
      :desc => "URL to open in the browser before each test. May be relative if WatirSplash common project is loaded."
    framework_option.call
    def new(name = "Application")
      WatirSplash::Generators::NewProject.start([Thor::Util.camel_case(name), options[:url], options[:framework], options.load_common?])
    end

    desc "new_common", "Create a new WatirSplash common project."
    method_option :url, :default => "http://localhost", :aliases => "-u",
      :desc => "URL for the application main page." 
    framework_option.call    
    def new_common
      WatirSplash::Generators::NewCommonProject.start([options[:url], options[:framework]])
    end

    if File.basename(Dir.pwd) =~ /^ui-test(-common)?$/
      desc "migrate", "Migrate old WatirSplash (version < 1.0) generated project to new."
      def migrate
        WatirSplash::Generators::MigrateProject.start
      end
    end

  end  
end
