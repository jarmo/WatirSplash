require "uri"

module WatirSplash
  module Generators
    class Page < Thor::Group
      include Thor::Actions

      argument :page_name
      argument :elements
      argument :namespace
      argument :url, :optional => true

      def self.source_root
        File.dirname(__FILE__) + "/templates"
      end

      def generate
        directory("page", ".")
      end

      def formatted_page_name
        Thor::Util.snake_case(page_name)
      end

      def formatted_namespace
        Thor::Util.snake_case(namespace)
      end

      def page_body
        str = ""
        str += %Q[url "#{url}"
] if url

        elements.each do |element|
          name, type, locator_name, locator_value = element.split(":")
          str += %Q[
      def #{name}
        #{type}(:#{locator_name} => "#{locator_value}") 
      end
]
        end
        str
      end

      def spec_body
        str = "#{formatted_page_name} = #{page_path}.new#{$/}"

        elements.each do |element|
          name, type, locator_name, locator_value = element.split(":")
          str += %Q[    # #{formatted_page_name}.#{name} # => #{type}(:#{locator_name} => "#{locator_value}")
]
        end
        str
      end

      def page_path
        "#{namespace}::Page::#{page_name}"
      end

    end
  end
end
