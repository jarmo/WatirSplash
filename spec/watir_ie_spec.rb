describe Watir::IE do

  before :each do
    goto "http://dl.dropbox.com/u/2731643/WatirSplash/test.html"
  end

  context Watir::Element do
    context "#save_as" do
      it "saves file with the browser" do
        begin
          file_path = link(:text => "Download").save_as(File.path("download.zip"))
          File.read(file_path).should == "this is a 'zip' file!"
        ensure
          FileUtils.rm file_path rescue nil
        end
      end

      it "allows only absolute paths" do
        lambda {link(:text => "Download").save_as("download.zip")}.should raise_exception
      end
    end
  end

  context Watir::FileField do
    context "#set" do
      it "sets the file to upload with the browser" do
        field = file_field(:id => "upload")
        file_path = File.expand_path(__FILE__)
        field.set file_path
        wait_until(5) {field.value =~ /#{File.basename(__FILE__)}/}
      end

      it "doesn't allow to use with non existing files" do
        field = file_field(:id => "upload")
        lambda {field.set "upload.zip"}.should raise_exception
      end
    end
  end

end