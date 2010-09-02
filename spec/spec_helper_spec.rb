require "spec"

describe WatirSplash::SpecHelper do

  it "opens browser automatically" do
    @browser.should exist
    @browser.url.should == "about:blank"
    @browser.title.should == ""
  end

  it "redirects method calls to Watir::Browser" do
    goto "http://google.com"
    url.should =~ /google/
    title.should =~ /google/i
    text_field = text_field(:name => "q")
    text_field.should exist
    text_field.should be_visible
  end

  it "has wait_until" do
    lambda {wait_until(0.5) {sleep 0.1; true}}.should_not raise_exception
    lambda {wait_until(0.5) {sleep 0.1; false}}.should raise_exception(Watir::WaitHelper::TimeoutError)
  end

  it "has wait_until?" do
    result = wait_until? {sleep 0.1; true}
    result.should be_true

    result = wait_until?(0.5) {sleep 0.1; false}
    result.should be_false
  end

  it "has file_path methods" do
    file_name = "blah.temp"
    ext = File.extname(file_name)
    base = File.basename(file_name, ext)
    expected_path = File.join(Dir.pwd, "results/files/#{base}_.*#{ext}")

    file_path(file_name).should =~ Regexp.new(expected_path)
    expected_path = expected_path.gsub("/", "\\")
    native_file_path(file_path(file_name)).should =~ Regexp.new(Regexp.escape(expected_path).gsub("\\.\\*", ".*"))
  end

  it "has download_file method" do
    begin
      goto "http://dl.dropbox.com/u/2731643/WatirSplash/download.html"
      link(:text => "Download").click_no_wait
      file = download_file("download.zip")
      File.read(file).should == "this is a 'zip' file!"
    ensure
      FileUtils.rm file rescue nil
    end
  end

  it "redirects usages of method 'p' to Watir::IE#p instead of Kernel.p" do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/elements.html"
    paragraph = p(:class => "my_pg")
    paragraph.should exist
    paragraph.text.should == "This is a paragraph!"
  end

end