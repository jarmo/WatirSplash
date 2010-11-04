class File
  class << self
    # returns unique file path for use in the examples
    #
    # all file names generated with this method will
    # be shown on the report upon test failure.
    def path(file_name, description=nil)
      WatirSplash::Util.formatter.file_path(file_name, description)
    end

    # returns native file path
    # e.g. on Windows:
    #   native_file_path("c:/blah/blah2/file.txt") => c:\\blah\\blah2\\file.txt
    def native_path(file_path)
      File::ALT_SEPARATOR ? file_path.gsub(File::SEPARATOR, File::ALT_SEPARATOR) : file_path
    end
  end
end