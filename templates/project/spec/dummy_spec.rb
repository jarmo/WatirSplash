# this is just a fully working dummy spec file which you can run to see if
# your configuration is correct and everything is working

describe "WatiRspec" do

  it "has the browser window opened" do
    url.should == "about:blank"
  end

  it "has easy access to ApplicationHelper methods" do
    # ApplicationHelper#helper_method_one will be executed
    helper_method_one.should == "one"
    # ApplicationHelper#has_second_method? will be execute
    should have_second_method
    # ApplicationHelper#correct? method will be execute
    should_not be_correct
  end

  it "fails the example and makes a screenshot of the browser" do
    false.should be_true
  end

  it "is in pending status" do
    goto "http://google.com"
    title.should == "Google"
    text_field(:name => "q").set "Bing"
    search_button = button(:name => "btnG")
    search_button.should exist
    search_button.should be_visible
    search_button.click
    text.should include("Bing")
    pending "this is a known 'bug'" do
      title.should == "Bing"
    end
  end

  it "has also access to global methods" do
    pending "this fails as long as there's not executed generate_common command
and it's not tied with this project" do
      new_global_method.should == "it just works"
    end
  end

end
