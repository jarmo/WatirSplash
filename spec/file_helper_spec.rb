describe File do

  before :all do
    @file_name = "blah.temp"
    @ext = File.extname(@file_name)
    @base = File.basename(@file_name, @ext)
  end

  it ".path returns unique file path" do
    expected_path = File.join(Dir.pwd, "results/files/#{@base}_.*#{@ext}")
    File.path(@file_name).should =~ Regexp.new(expected_path)
  end

  it ".native_path returns unique file path with native path separator" do
    expected_path = File.join(Dir.pwd, "results/files/#{@base}_.*#{@ext}").gsub("/", "\\")
    File.native_path(File.path(@file_name)).should =~ Regexp.new(Regexp.escape(expected_path).gsub("\\.\\*", ".*"))
  end

end