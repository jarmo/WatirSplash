require "spec"

describe WatirSplash::SpecHelper do

  it "opens browser automatically" do
    @browser.should exist
    @browser.url.should == "about:blank"
    @browser.title.should == ""
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

  it "has File.path and File.native_path methods" do
    file_name = "blah.temp"
    ext = File.extname(file_name)
    base = File.basename(file_name, ext)
    expected_path = File.join(Dir.pwd, "results/files/#{base}_.*#{ext}")

    File.path(file_name).should =~ Regexp.new(expected_path)
    expected_path = expected_path.gsub("/", "\\")
    File.native_path(File.path(file_name)).should =~ Regexp.new(Regexp.escape(expected_path).gsub("\\.\\*", ".*"))
  end

  it "redirects usages of method 'p' to Watir::IE#p instead of Kernel.p" do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/test.html"
    paragraph = p(:class => "my_pg")
    paragraph.should exist
    paragraph.text.should == "This is a paragraph!"
  end

end