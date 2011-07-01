# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "watirsplash/version"

Gem::Specification.new do |s|
  s.name = %q{watirsplash}
  version = WatirSplash::Version::WATIRSPLASH 
  s.version = version
  s.authors = [%q{Jarmo Pertman}]
  s.email = %q{jarmo.p@gmail.com}
  s.description = %q{WatirSplash makes testing of web applications splashin' easy by combining best features of Watir, RSpec and Ruby!}
  s.homepage = %q{http://github.com/jarmo/WatirSplash}
  s.post_install_message = %Q{*************************

Thank you for installing WatirSplash #{version}! Don't forget to take a look at the README and History files!

Execute `watirsplash new` under your project's directory to generate a default project structure.

*************************}
  s.summary = %Q{watirsplash #{version}}
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- spec/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency("rake", "0.8.7")
  s.add_dependency("bundler", "~>1.0")
  s.add_dependency("thor", "~>0")
  s.add_dependency("require_all")
  s.add_dependency("syntax")
end

