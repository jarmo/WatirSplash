require "thor"
require "thor/group"
require "watirsplash/generators/new_project"
require "watirsplash/generators/new_common_project"
require "watirsplash/generators/migrate_project"

module WatirSplash
  class CLI < Thor

    desc "new [APPLICATION_NAME]", "Creates a new WatirSplash project."
    method_option :load_common, :type => :boolean, :default => false, :aliases => "-l",
      :desc => "Load WatirSplash common project automatically."
    method_option :url, :default => "about:blank", :aliases => "-u",
      :desc => "URL to open in the browser before each test. May be relative if WatirSplash common project is loaded."
    def new(name = "Application")
      WatirSplash::Generators::NewProject.start([Thor::Util.camel_case(name), options[:url], options.load_common?])
    end

    desc "new_common", "Create a new WatirSplash common project."
    method_option :url, :default => "http://localhost",
      :desc => "url for the application main page" 
    def new_common
      WatirSplash::Generators::NewCommonProject.start([options[:url]])
    end

    if File.basename(Dir.pwd) =~ /^ui-test(-common)?$/
      desc "migrate", "Migrates old WatirSplash generated project to new."
      def migrate
        WatirSplash::Generators::MigrateProject.start
      end
    end

  end  
end
