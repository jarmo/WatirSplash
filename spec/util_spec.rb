describe WatirSplash::Util do

  before :all do
    @file_name = "blah.temp"
    @ext = File.extname(@file_name)
    @base = File.basename(@file_name, @ext)
  end

  it ".file_path returns unique file path" do
    expected_path = File.join(Dir.pwd, "results/files/#{@base}_.*#{@ext}")
    WatirSplash::Util.file_path(@file_name).should =~ Regexp.new(expected_path)
  end

  it ".file_native_path returns unique file path with native path separator" do
    expected_path = File.join(Dir.pwd, "results/files/#{@base}_.*#{@ext}").gsub("/", "\\")
    WatirSplash::Util.file_native_path(WatirSplash::Util.file_path(@file_name)).should =~ Regexp.new(Regexp.escape(expected_path).gsub("\\.\\*", ".*"))
  end

end
