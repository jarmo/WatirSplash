class DummyPage < WatirSplash::Page::Base
  url "http://bing.com"

  def something
    modify Hash.new,
      :store => lambda {|a,b| a + b},
      :new_method => lambda {[]},
      :another_page => lambda {redirect_to AnotherDummyPage},
      :another_page_with_new_browser => lambda {|browser| redirect_to AnotherDummyPage, browser}
  end
end

class AnotherDummyPage < WatirSplash::Page::Base
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
      browser.url.should =~ %r{bing.com}
    end

    it "allows to reuse existing browser" do
      browser = WatirSplash::Browser.new
      browser.goto "http://google.com/ncr"

      page = DummyPage.new(browser)
      page_browser = page.instance_variable_get(:@browser)
      page_browser.should == browser
      page_browser.url.should =~ %r{google.com}
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

  context "#redirect_to" do
    it "redirects to the new page reusing the current browser" do
      page = DummyPage.new
      another_page = page.something.another_page
      another_page.should be_kind_of(AnotherDummyPage)
      another_page.url.should =~ %r{bing.com}
    end

    it "redirects to the new page using the provided browser" do
      page = DummyPage.new
      old_browser = WatirSplash::Browser.current

      browser = WatirSplash::Browser.new
      browser.goto "http://google.com/ncr"
      new_page = page.something.another_page_with_new_browser browser
      new_page_browser = new_page.instance_variable_get(:@browser)
      new_page_browser.should == browser
      new_page_browser.url.should =~ %r{google.com}

      page_browser = page.instance_variable_get(:@browser)
      page_browser.should == old_browser
      page_browser.url.should =~ %r{bing.com}
    end
  end

  context "#method_missing" do
    it "gets SpecHelper module included into class" do
      DummyPage.included_modules.should include(WatirSplash::SpecHelper)
    end

    it "redirects all missing methods to browser object" do
      page = DummyPage.new
      page.should_not respond_to(:text_field)
      page.text_field(:id => /something/).should be_kind_of(Watir::TextField)
    end
  end

  after :each do
    WatirSplash::Browser.current.close
  end
end
