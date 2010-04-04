require "watirspec"
require "spec/autorun"

describe Watir::TableRow do
  include WatiRspec::SpecHelper

  before :all do
    goto "http://dl.dropbox.com/u/2731643/misc/tables.html"
  end

  it "#to_a works with regular row" do
    first_row = table(:id => "normal")[1]
    first_row.to_a.should =~ %w[1 2 3]
  end

  it "#to_a works with headers in row" do
    first_row = table(:id => "headers")[1]
    first_row.to_a.should =~ %w[1 2 3 4]
  end

  it "#to_a works with nested tables" do
    second_row = table(:id => "nested")[2]
    second_row.to_a.should =~ [[%w[11 12], %w[13 14]], "3"]
  end

  it "#to_a works with colspan" do
    second_row = table(:id => "colspan")[2]
    second_row.to_a.should == ["3"]
  end

end