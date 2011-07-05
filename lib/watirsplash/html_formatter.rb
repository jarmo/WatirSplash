require 'rspec/core/formatters/html_formatter'
require 'pathname'
require 'fileutils'

module WatirSplash
  # Custom RSpec formatter for WatirSplash
  # * saves screenshot of the browser upon test failure
  # * saves html of the browser upon test failure
  # * saves javascript error dialog upon test failure
  # * saves all files generated/downloaded during the test and shows them in the report
  class HtmlFormatter < ::RSpec::Core::Formatters::HtmlFormatter

    def initialize(output) # :nodoc:
      @output_dir = File.expand_path(File.dirname(output))
      archive_results

      puts "Results will be saved into the directory #{@output_dir}"
      @files_dir = File.join(@output_dir, "files")
      FileUtils.mkdir_p(@files_dir)
      @files_saved_during_example = []
      super(File.open(output, "w"))
    end

    def example_group_started(example_group) # :nodoc:
      @files_saved_during_example.clear
      append_extra_information_to_description(example_group)
      super
    end

    def example_started(example) # :nodoc:
      @files_saved_during_example.clear
      example.metadata[:description] += "#{example.metadata[:location].scan(/:\d+$/)} (#{Time.now.strftime("%H:%M:%S")})"
      super
    end

    def extra_failure_content(exception) # :nodoc:
      if WatirSplash::Browser.current && WatirSplash::Browser.current.exists?
        save_screenshot
        save_html
      end

      content = []
      content << "<span>"
      @files_saved_during_example.each {|f| content << link_for(f)}
      content << "</span>"
      super + content.join($/)
    end

    def link_for(file) # :nodoc:
      return unless File.exists?(file[:path])

      description = file[:desc] ? file[:desc] : File.extname(file[:path]).upcase[1..-1]
      path = Pathname.new(file[:path])
      "<a href='#{path.relative_path_from(Pathname.new(@output_dir))}'>#{description}</a>&nbsp;"
    end

    def save_html # :nodoc:
      file_name = file_path("browser.html")
      begin
        html = WatirSplash::Browser.current.html
        File.open(file_name, 'w') {|f| f.puts html}
      rescue => e
        $stderr.puts "saving of html failed: #{e.message}"
      end
      file_name
    end

    def save_screenshot(description="Screenshot", hwnd=nil) # :nodoc:
      file_name = file_path("screenshot.png", description)
      WatirSplash::Browser.current.save_screenshot(:file_name => file_name, :hwnd => hwnd)
      file_name
    end

    # Generates unique file name and path for each example.
    #
    # All file names generated with this method will be shown
    # on the report.
    def file_path(file_name, description=nil)
      extension = File.extname(file_name)
      basename = File.basename(file_name, extension)
      file_path = File.join(@files_dir, "#{basename}_#{Time.now.strftime("%H%M%S")}_#{example_group_number}_#{example_number}#{extension}")
      @files_saved_during_example.unshift(:desc => description, :path => file_path)
      file_path
    end

    private

    def archive_results
      if File.exists?(@output_dir)
        archive_dir = File.join(@output_dir, "../archive")
        FileUtils.mkdir_p(archive_dir) unless File.exists?(archive_dir)
        FileUtils.mv @output_dir, File.join(archive_dir, "#{File.basename(@output_dir)}_#{File.mtime(@output_dir).strftime("%y%m%d_%H%M%S")}")
      end
    end

    def append_extra_information_to_description(example_group)
      date = Time.now.strftime("%d.%m.%Y")
      spec_location, line_no = extract_example_group_metadata example_group.metadata[:example_group]
      return unless spec_location
      spec_location = Pathname.new(spec_location)
      relative_spec_path = spec_location.relative_path_from(Pathname.new(Dir.pwd + "/spec")).to_s
      appended_description = " @ #{relative_spec_path}#{line_no} (#{date})"
      example_group.metadata[:example_group][:description] += appended_description
    end

    def extract_example_group_metadata example_group
      unless example_group[:example_group]
        example_group[:block].to_s.scan(/@(.*)(:\d+)>$/).flatten
      else
        example_group_metadata example_group[:example_group]
      end
    end
  end
end
