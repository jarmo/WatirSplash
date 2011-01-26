require 'rspec/core/formatters/html_formatter'
require 'rspec/core/formatters/snippet_extractor'

# patch for https://github.com/rspec/rspec-core/issues/#issue/214
module RSpec
  module Core
    module Formatters
      class HtmlFormatter < BaseTextFormatter
        def extra_failure_content(exception)
          require 'rspec/core/formatters/snippet_extractor'
          backtrace = exception.backtrace.map {|line| backtrace_line(line)}
          backtrace.compact!
          @snippet_extractor ||= SnippetExtractor.new
          "    <pre class=\"ruby\"><code>#{@snippet_extractor.snippet(backtrace)}</code></pre>"
        end
      end

      class SnippetExtractor
        def snippet(backtrace)
          raw_code, line = snippet_for(backtrace[0])
          highlighted = @@converter.convert(raw_code, false)
          highlighted << "\n<span class=\"comment\"># gem install syntax to get syntax highlighting</span>" if @@converter.is_a?(NullConverter)
          post_process(highlighted, line)
        end
      end
    end
  end
end

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
