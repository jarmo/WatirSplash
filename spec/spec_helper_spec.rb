describe WatirSplash::SpecHelper do

  it "opens browser automatically" do
    WatirSplash::Util.formatter.browser.should exist
    WatirSplash::Util.formatter.browser.url.should == "about:blank"
  end

  it "redirects method calls to Watir::Browser" do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/test.html"
    url.should =~ /test/
    title.should == "WatirSplash testing page"
    text_field = text_field(:name => "field1")
    text_field.should exist
    text_field.should be_visible
    text_field.value == "empty value"
  end

  it "redirects usages of method 'p' to Watir::IE#p instead of Kernel.p" do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/test.html"
    paragraph = p(:class => "my_pg")
    paragraph.should exist
    paragraph.text.should == "This is a paragraph!"
  end

end
