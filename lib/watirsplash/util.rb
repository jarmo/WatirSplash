module WatirSplash
  # class for common functionality
  class Util
    @@ui_test_common_dir = "ui-test-common"

    class << self

      # loads ui-test-common/environment.rb
      #
      # ui-test-common has to be located at some higher level within directory
      # structure compared to project/ui-test directory
      def load_common
        dir = common_dir
        puts "Loading ui-test-common from #{dir}..."
        require File.join(dir, "environment.rb")
      end

      def load_environment
        env_file = File.join(Dir.pwd, "environment.rb")
        if File.exists?(env_file)
          require env_file
        else
          Dir.chdir("..") do
            load_environment if Dir.entries(Dir.pwd).include?("..")
          end
        end
      end

      private

      def common_dir
        Dir.chdir("..") do
          dirs = Dir.entries(Dir.pwd).find_all {|entry| File.directory?(entry)}
          if dirs.include?(@@ui_test_common_dir) && File.exists?(@@ui_test_common_dir + "/environment.rb")
            File.join(Dir.pwd, @@ui_test_common_dir)
          elsif dirs.include?("..")
            common_dir
          else
            raise "#{@@ui_test_common_dir} directory was not found! It has to exist somewhere higher in directory tree than your project's directory and it has to have environment.rb file in it!"
          end
        end
      end

    end
  end
end