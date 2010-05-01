require File.dirname(__FILE__) + '/spec_helper'

describe "Array match_array matcher" do

  it "matches other arrays with regexps" do
    expected_ary = ["1", "2", "3", /\d/]
    ["1", "2", "3", "5"].should match_array(expected_ary)

    expected_ary = ["1", ["2", /\d+/], /3/]
    ["1", [], "4"].should_not match_array(expected_ary)
    ["1", ["2", "55"], "3"].should match_array(expected_ary)
  end

  it "doesn't work with other objects than Array" do
    lambda {"".should match_array("")}.should raise_exception
    lambda {[].should match_array("")}.should raise_exception
    lambda {"".should match_array([])}.should raise_exception
  end

end