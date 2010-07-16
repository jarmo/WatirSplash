require "spec"

describe Watir::IE do

  it "uses currentStyle method to show computed style" do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/tables.html"
    t = table(:id => "normal")
    normal_cell = t[1][1]
    normal_cell.text.should == "1"
    normal_cell.style.color.should == "#000000"

    red_cell = t.cell(:class => "reddish")
    red_cell.text.should == "9"
    red_cell.style.color.should == "red"
  end

  it "closes the browser even when Watir::IE#run_error_checks throws an exception" do
    @browser.add_checker lambda {raise "let's fail IE#wait in IE#close"}
    @browser.should exist
    lambda {@browser.close}.should_not raise_exception
    @browser.should_not exist
  end

end