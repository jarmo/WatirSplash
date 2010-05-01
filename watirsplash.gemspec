# -*- encoding: utf-8 -*-
require "lib/watirsplash/version"

Gem::Specification.new do |s|
  s.name = %q{watirsplash}
  s.version = WatirSplash::VERSION
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jarmo Pertman"]
  s.description = %q{Combines best features of Watir, RSpec and Ruby for browser-based functional testing.}
  s.email = ["jarmo.p@gmail.com"]
  s.executables = ["watirsplash"]
  s.extra_rdoc_files = ["README.rdoc", "History.rdoc", "License.txt"]
  s.rdoc_options << "--main" << "README.rdoc" <<
          "--template" << "hanna" <<
          "--inline-source" << "--format=html"
  ignored_files = File.readlines(".gitignore").map {|l| l.strip.gsub("*", "")}
  ignored_files << ".gitignore" << ".gemspec"
  s.files = Dir.glob("**/*").delete_if {|f| f =~ Regexp.union(*ignored_files)}
  s.homepage = %q{http://github.com/jarmo/WatirSplash}
  s.post_install_message = %Q{#{"*"*25}

Thank you for installing WatirSplash #{WatirSplash::VERSION}! Don't forget to take a look at README file!

Execute "watirsplash generate" under your project's directory to generate default project structure.

#{"*"*25}}
  s.require_paths = ["lib"]
  s.summary = %Q{watirsplash #{WatirSplash::VERSION}}

  s.add_dependency("watir", ">=1.6.5")
  s.add_dependency("rspec", ">=1.3.0")
  s.add_dependency("diff-lcs")
  s.add_dependency("require_all")
  s.add_dependency("rmagick")
  s.add_dependency("syntax")
  s.add_dependency("win32console")
  s.add_dependency("win32screenshot")
end
