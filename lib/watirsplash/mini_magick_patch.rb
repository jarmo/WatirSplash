module MiniMagick
  class Image
    class << self
      # patch to handle paths with spaces in it until new version of MiniMagick
      # gets released.
      def write(output_to)
        if output_to.kind_of?(String) || !output_to.respond_to?(:write)
          FileUtils.copy_file @path, output_to
          run_command "identify", output_to.to_s.inspect # Verify that we have a good image
        else # stream
          File.open(@path, "rb") do |f|
            f.binmode
            while chunk = f.read(8192)
              output_to.write(chunk)
            end
          end
          output_to
        end
      end
    end
  end
end
