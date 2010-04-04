require "watirspec"
require "spec/autorun"

describe Watir::Table do
  include WatiRspec::SpecHelper

  before :all do
    goto "http://dl.dropbox.com/u/2731643/misc/tables.html"
  end

  it "#to_a works with regular table" do
    expected_table = [
            %w[1 2 3],
            %w[4 5 6],
            %w[7 8 9]
    ]
    table(:id => "normal").to_a.should =~ expected_table
  end

  it "#to_a works with table with headers" do
    expected_table = [
            %w[1 2 3 4],
            %w[5 6 7 8],
            %w[9 10 11 12],
    ]
    table(:id => "headers").to_a.should =~ expected_table
  end

  it "#to_a works with nested tables" do
    expected_table = [
            %w[1 2],
            [[%w[11 12], %w[13 14]], "3"]
    ]
    table(:id => "nested").to_a.should =~ expected_table
  end

  it "#to_a works with colspan" do
    expected_table = [
            %w[1 2],
            ["3"]
    ]
    table(:id => "colspan").to_a.should =~ expected_table
  end
end