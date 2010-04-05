Spec::Runner.configure do |config| #:nodoc:
  config.include(WatiRspec::SpecHelper)

  config.before(:all) do
    open_browser_at "about:blank"
  end

  config.after(:all) do
    close
  end
end

module Spec #:nodoc:all
  class ExampleGroup
    subject {self}
  end
end

Spec::Matchers.define :match_array do |array2|
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
