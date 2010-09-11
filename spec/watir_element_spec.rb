require "spec"

describe Watir::Element do

  before :each do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/test.html"
    @div = div(:id => 'div1')
  end

  it "has method #present?" do
    @div.should exist
    @div.should be_visible
    @div.should be_present

    execute_script("toggle()")
    @div.should exist
    @div.should_not be_visible
    @div.should_not be_present

    div = div(:id => 'non-existing')
    div.should_not exist
    lambda {div.visible?}.should raise_exception
    div.should_not be_present
  end

  it "has method #when_present" do
    @div.should be_visible
    @div.when_present.text.should == "Div content"
    link(:id => "toggle").click
    wait_until {not @div.visible?}

    link(:id => "toggle").click
    @div.when_present.text.should == "Div content"
    @div.should be_visible

    @div.when_present {1 + 1}.should == 2

    lambda {div(:id => 'non-existing').when_present(0.1).text}.should raise_exception
  end

  it "has method #wait_until_present" do
    @div.should be_visible
    @div.wait_until_present
    @div.text.should == "Div content"
    link(:id => "toggle").click
    wait_until {not @div.visible?}

    link(:id => "toggle").click
    @div.wait_until_present
    @div.text.should == "Div content"
    @div.should be_visible

    lambda {div(:id => 'non-existing').wait_until_present(0.1)}.should raise_exception
  end

  it "has method #wait_while_present" do
    @div.should be_visible
    link(:id => "toggle").click
    @div.wait_while_present
    @div.should_not be_visible

    link(:id => "toggle").click
    @div.wait_while_present
    @div.should_not be_visible

    wait_until {@div.visible?}
    lambda {@div.wait_while_present(0.1)}.should raise_exception
  end
end