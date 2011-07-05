class DummyPage < WatirSplash::Page::Base
  url "http://bing.com"

  def something
    modify Hash.new,
      :store => lambda {|a,b| a + b},
      :new_method => lambda {[]}
  end
end

describe WatirSplash::Page::Base do
  before :all do
    # close the browser opened in environment.rb    
    WatirSplash::Browser.current.close
  end

  context ".new" do
    it "opens up a new browser if no browser specified" do
      page = DummyPage.new
      browser = page.instance_variable_get(:@browser)
      browser.should respond_to(:title)
      browser.url.should =~ /bing\.com/
    end

    it "allows to reuse existing browser" do
      browser = WatirSplash::Browser.new
      browser.goto "http://google.com/ncr"

      page = DummyPage.new(browser)
      page_browser = page.instance_variable_get(:@browser)
      page_browser.should == browser
      page_browser.url.should =~ /google\.com/
    end
  end

  context "#modify" do
    it "returns the instance of the object" do
      page = DummyPage.new
      page.something.should == {}
    end

    it "allows to modify default behavior of the instance's methods" do
      page = DummyPage.new
      page.something.store(1, 2).should == 3
    end

    it "executes the original method too" do
      page = DummyPage.new
      res = page.something
      res.store(1, 2)
      res.should == {1 => 2}
    end

    it "doesn't modify instance methods of the class itself" do
      h = Hash.new
      h.store(1, 2).should == 2
      h.should == {1 => 2}
    end

    it "allows to add new methods too" do
      page = DummyPage.new
      page.something.new_method.should == []
    end
  end

  context "#method_missing" do
    it "gets SpecHelper module included into class" do
      DummyPage.included_modules.should include(WatirSplash::SpecHelper)
    end

    it "redirects all missing methods to browser object" do
      page = DummyPage.new
      page.should_not respond_to(:text_field)
      page.text_field(:id => /somethin/).should be_kind_of(Watir::TextField)
    end
  end

  after :each do
    WatirSplash::Browser.current.close
  end
end
