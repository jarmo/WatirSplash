require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    version = File.read("VERSION").strip
    gem.name = "watirsplash"
    gem.summary = %Q{watirsplash #{version}}
    gem.description = %q{WatirSplash makes testing of web applications splashin' easy by combining best features of Watir, RSpec and Ruby!}
    gem.email = "jarmo.p@gmail.com"
    gem.homepage = "http://github.com/jarmo/WatirSplash"
    gem.authors = ["Jarmo Pertman"]
    gem.executables = ["watirsplash"]
    gem.extra_rdoc_files = ["README.rdoc", "History.rdoc", "License.txt"]
    gem.rdoc_options << "--main" << "README.rdoc" <<
            "--template" << "hanna" <<
            "--inline-source" << "--format=html"
    ignored_files = File.readlines(".gitignore").map {|l| l.strip.gsub("*", "")}
    ignored_files << ".gitignore" << ".gemspec"
    gem.files = Dir.glob("**/*").delete_if {|f| f =~ Regexp.union(*ignored_files)}
    gem.files << "lib/watirsplash/generators/templates/new_project/.rspec"
    gem.post_install_message = %Q{#{"*"*25}

Thank you for installing WatirSplash #{version}! Don't forget to take a look at README and History files!

Execute "watirsplash generate" under your project's directory to generate default project structure.

#{"*"*25}}

    gem.add_dependency("watir", "=1.6.7")
    gem.add_dependency("rspec", "~>2.4")
    gem.add_dependency("rautomation", "~>0.1")
    gem.add_dependency("require_all")
    gem.add_dependency("syntax")
    gem.add_dependency("win32screenshot", ">=0.0.4")
    gem.add_dependency("thor", "~>0.14")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:rcov) do |t|
  t.rcov = true
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "WatirSplash #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
