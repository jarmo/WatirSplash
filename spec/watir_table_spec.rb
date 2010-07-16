require "spec"

describe Watir::Table do
  include WatirSplash::SpecHelper

  before :all do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/tables.html"
  end

  it "#to_a works with regular table" do
    expected_table = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"]
    ]
    table(:id => "normal").to_a.should == expected_table
  end

  it "#to_a works with table with headers" do
    expected_table = [
            ["1", "2", "3", "4"],
            ["5", "6", "7", "8"],
            ["9", "10", "11", "12"]
    ]
    table(:id => "headers").to_a.should == expected_table
  end

  it "#to_a works with nested tables" do
    expected_table =
            [
                    ["1", "2"],
                    [[["11", "12"],
                      ["13", "14"]], "3"]
            ]
    table(:id => "nested").to_a(2).should == expected_table
  end

  it "#to_a works with nested table with non-direct child" do
    expected_table =
            [
                    ["1", "2"],
                    [[["11", "12"],
                      ["13", "14"]], "3"]
            ]

    table(:id => "nestednondirectchild").to_a(2).should == expected_table
  end

  it "#to_a works with deep-nested tables" do
    expected_table =
            [
                    ["1", "2"],
                    [[["11", "12"],
                      [[["404", "405"],
                        ["406", "407"]], "14"]], "3"]
            ]
    table(:id => "deepnested").to_a(3).should == expected_table
  end

  it "#to_a works with colspan" do
    expected_table =
            [
                    ["1", "2"],
                    ["3"]
            ]
    table(:id => "colspan").to_a.should == expected_table
  end

  it "#to_a works with rowspan" do
    expected_table =
            [
                    ["1", "2"],
                    ["3", "4"],
                    ["5"]
            ]
    table(:id => "rowspan").to_a.should match_array(expected_table)
  end
end