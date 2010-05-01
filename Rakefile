require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    version = File.read("VERSION").strip
    gem.name = "watirsplash"
    gem.summary = %Q{watirsplash #{version}}
    gem.description = %q{Combines best features of Watir, RSpec and Ruby for browser-based functional testing.}
    gem.email = "jarmo.p@gmail.com"
    gem.homepage = "http://github.com/jarmo/my-testing-library"
    gem.authors = ["Jarmo Pertman"]
    gem.executables = ["watirsplash"]
    #gem.extra_rdoc_files = ["README.rdoc", "History.rdoc", "License.txt"]
    gem.rdoc_options << "--main" << "README.rdoc" <<
            "--template" << "hanna" <<
            "--inline-source" << "--format=html"
    ignored_files = File.readlines(".gitignore").map {|l| l.strip.gsub("*", "")}
    ignored_files << ".gitignore" << ".gemspec"
    gem.files = Dir.glob("**/*").delete_if {|f| f =~ Regexp.union(*ignored_files)}
    gem.post_install_message = %Q{#{"*"*25}

Thank you for installing WatirSplash #{version}! Don't forget to take a look at README file!

Execute "watirsplash generate" under your project's directory to generate default project structure.

#{"*"*25}}

    gem.add_dependency("watir", ">=1.6.5")
    gem.add_dependency("rspec", ">=1.3.0")
    gem.add_dependency("diff-lcs")
    gem.add_dependency("require_all")
    gem.add_dependency("rmagick")
    gem.add_dependency("syntax")
    gem.add_dependency("win32console")
    gem.add_dependency("win32screenshot")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
  spec.rcov_opts << '--sort coverage --text-summary --aggregate coverage.data'
end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "my-testing-library #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
