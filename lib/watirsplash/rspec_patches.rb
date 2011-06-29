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

  config.after(:all) do
    close if @browser
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

# patch for #in(timeout) method
module RSpec::Matchers
  class Change
    def matches?(event_proc)
      raise_block_syntax_error if block_given?
      
      # to make #change work with #in(timeout) method
      unless defined? @actual_before
        @actual_before = evaluate_value_proc
        event_proc.call
      end
      @actual_after = evaluate_value_proc
    
      (!change_expected? || changed?) && matches_before? && matches_after? && matches_expected_delta? && matches_min? && matches_max?
    end
  end

  alias_method :make, :change
end

# add #in(timeout) method for every matcher for allowing to wait until some condition.
#     div.click
#     another_div.should be_present.in(5)
#
#     expect {
#       div.click
#     }.to change {another_div.text}.from("before").to("after").in(5)
#
#     expect {
#       div.click
#     }.to make {another_div.present?}.in(5)
#
#     expect {
#       div.click
#     }.to change {another_div.text}.soon
#
# use with ActiveSupport to use descriptive methods for numbers:
#     require "active_support"
#     another_div.should exist.in(5.minutes)
RSpec::Matchers.constants.each do |const|
  RSpec::Matchers.const_get(const).class_eval do

    inst_methods = instance_methods.map {|m| m.to_sym}

    if !(inst_methods.include?(:__matches?) || inst_methods.include?(:__does_not_match?)) && 
        (inst_methods.include?(:matches?) || inst_methods.include?(:does_not_match?))

      def in(timeout)
        Kernel.warn "DEPRECATION NOTICE: #in(timeout) is DEPRECATED, please use #within(timeout) method instead!"
        within(timeout)
      end

      def within(timeout)
        @timeout = timeout
        self
      end

      def soon 
        within(30)
      end      

      def seconds
        # for syntactic sugar
        self
      end

      alias_method :second, :seconds

      def minutes
        return unless @timeout
        @timeout *= 60
        self
      end

      alias_method :minute, :minutes
    end

    if inst_methods.include? :matches?
      alias_method :__matches?, :matches? 

      def matches?(actual)
        @timeout ? (Watir::Wait.until(@timeout) {__matches?(actual)} rescue false) : __matches?(actual)
      end
    end

    if inst_methods.include? :does_not_match?
      alias_method :__does_not_match?, :does_not_match?

      def does_not_match?(actual)
        @timeout ? (Watir::Wait.until(@timeout) {__does_not_match?(actual)} rescue false) : __does_not_match?(actual)
      end
    elsif inst_methods.include? :matches?
      def does_not_match?(actual)
        @timeout ? !(Watir::Wait.while(@timeout) {__matches?(actual)} rescue true) : !__matches?(actual)
      end
    end
  end
end
