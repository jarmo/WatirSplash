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

  after :each do
    WatirSplash::Browser.current.close
  end

end
