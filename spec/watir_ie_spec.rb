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

  it "has #save_as method for Watir::Element" do
    begin
      goto "http://dl.dropbox.com/u/2731643/WatirSplash/download.html"
      file_path = link(:text => "Download").save_as(File.path("download.zip"))
      File.read(file_path).should == "this is a 'zip' file!"
    ensure
      FileUtils.rm file_path rescue nil
    end
  end

  it "allows only absolute paths for #save_as" do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/download.html"
    lambda {link(:text => "Download").save_as("download.zip")}.should raise_exception
  end

  it "works with FileField#set" do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/elements.html"
    field = file_field(:id => "upload")
    file_path = File.expand_path(__FILE__)
    field.set file_path
    field.value.should match(/#{File.basename(__FILE__)}/)
  end

  it "doesn't allow to use FileField#set with non existing file" do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/elements.html"
    field = file_field(:id => "upload")
    lambda {field.set "upload.zip"}.should raise_exception
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

  it "closes the browser even when Watir::IE#run_error_checks throws an exception" do
    @browser.add_checker lambda {raise "let's fail IE#wait in IE#close"}
    @browser.should exist
    lambda {@browser.close}.should_not raise_exception
    @browser.should_not exist
  end

end