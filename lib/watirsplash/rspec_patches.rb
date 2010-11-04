RSpec.configure do |config| #:nodoc:
  config.include(WatirSplash::SpecHelper)

  config.before(:all) do
    open_browser_at "about:blank"
  end

  config.after(:all) do
    close
  end
end

module RSpec #:nodoc:all
  module Core
    class ExampleGroup
      subject {self}
    end

    class Configuration
      def reporter=(reporter)
        @reporter = reporter
      end

      public :built_in_formatter
    end

  end
end

# match_array is useful for matching arrays where some elements are regular expressions.
#    expected_array = ["1", "2", /\d+/, "3"]
#
#    ["1", "2", "66", "3"].should match_array(expected_array)
#    table(:id => "table_id").to_a.should match_array(expected_array)
RSpec::Matchers.define :match_array do |array2|
  match do |array1|
    raise "match_array works only with Array objects!" unless array1.is_a?(Array) && array2.is_a?(Array)
    match?(array1, array2)
  end

  def match?(array1, array2)
    array2.each_with_index do |element, i|
      if element.is_a?(Array)
        return false unless match?(array1[i], element)
      elsif element.is_a?(Regexp)
        return false unless array1[i] =~ element
      else
        return false unless array1[i] == element
      end
    end

    true
  end
end
