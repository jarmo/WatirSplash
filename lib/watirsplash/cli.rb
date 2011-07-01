require "thor"
require "thor/group"
require "watirsplash/generators/helper"
require "watirsplash/generators/new_project"
require "watirsplash/generators/page"
require "watirsplash/util"

module WatirSplash
  class CLI < Thor
    extend Generators::Helper

    unless Dir.entries(Dir.pwd).include? ".rspec"
      desc "new [DIRECTORY_NAME]", "Create a new WatirSplash project."
      method_option :url, :default => "about:blank", :aliases => "-u",
        :desc => "URL for the application under test."
      method_option :framework, :default => "default", :aliases => "-f",
        :desc => "Framework to use. Possible values are #{supported_frameworks.join(", ")}."
      def new(name = "ui-test")
        WatirSplash::Generators::NewProject.start([name, options[:url], options[:framework]])
      end
    end

    if Dir.entries(Dir.pwd).include? ".rspec"
      desc "page PAGE_NAME [element_name:element_type:locator_name:locator_value]", "Create a new WatirSplash page."
      method_option :spec, :default => true, :aliases => "-s", :type => :boolean,
        :desc => "Create spec file for page."
      method_option :url, :default => nil, :aliases => "-u",
        :desc => "URL for the page if directly accessible."
      method_option :module, :default => "App", :aliases => "-m",
        :desc => "Namespace module for the page."
      def page(page_name = "Main", *elements)
        WatirSplash::Generators::Page.start([page_name.gsub("-", "_"), elements, options[:module].gsub("-", "_"), options[:spec], options[:url]])
      end
    end

  end  
end
