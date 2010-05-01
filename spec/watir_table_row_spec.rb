describe Watir::TableRow do
  include WatirSplash::SpecHelper

  before :all do
    goto "http://dl.dropbox.com/u/2731643/misc/tables.html"
  end

  it "#to_a works with regular row" do
    first_row = table(:id => "normal")[1]
    first_row.to_a.should == ["1", "2", "3"]
  end

  it "#to_a works with headers in row" do
    first_row = table(:id => "headers")[1]
    first_row.to_a.should == ["1", "2", "3", "4"]
  end

  it "#to_a works with nested tables" do
    second_row = table(:id => "nested")[2]
    second_row.to_a(2).should == [[["11", "12"], ["13","14"]], "3"]
  end

  it "#to_a works with deep-nested tables" do
    second_row = table(:id => "deepnested")[2]
    second_row.to_a(3).should == [[["11", "12"],
                                [[["404", "405"], ["406", "407"]], "14"]], "3"]
  end

  it "#to_a works with colspan" do
    second_row = table(:id => "colspan")[2]
    second_row.to_a.should == ["3"]
  end

  it "#to_a works with rowspan" do
    t = table(:id => "rowspan")
    second_row = t[2]
    second_row.to_a.should == ["3", "4"]

    third_row = t[3]
    third_row.to_a.should == ["5"]
  end

end