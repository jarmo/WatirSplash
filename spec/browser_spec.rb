describe WatirSplash::Browser do

  before :all do
    # close the browser opened in environment.rb
    WatirSplash::Browser.current.close
  end

  it "opens up the browser" do
    browser = WatirSplash::Browser.new
    browser.should exist
    browser.should respond_to(:title)
  end

  it "stores the current browser" do
    browser = WatirSplash::Browser.new
    browser.should == WatirSplash::Browser.current
  end

  it "detects JavaScript errors" do
    browser = WatirSplash::Browser.new
    browser.goto "http://dl.dropbox.com/u/2731643/WatirSplash/test.html"
    browser.execute_script("window.originalOnErrorExecuted").should_not be_true

    expect {
      browser.link(:id => "errorLink").click
    }.to raise_error(WatirSplash::JavaScriptError, /JavaScript error:.*unexistingVar/)
    browser.execute_script("window.originalOnErrorExecuted").should be_true    

    expect {
      browser.link(:id => "toggle").click
    }.not_to raise_error
  end

  after :each do
    WatirSplash::Browser.current.close
  end

end
