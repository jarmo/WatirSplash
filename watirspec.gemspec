# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{watirspec}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jarmo Pertman"]
  s.description = %q{Integration of best features of Watir and RSpec for browser-based functional testing.}
  s.email = ["jarmo.p@gmail.com"]
  s.executables = ["watirspec"]
  s.extra_rdoc_files = ["License.txt"]
  s.files = Dir.glob("**/*").delete_if {|f| f =~ /watirspec\.gemspec|\.gitignore|\.idea/}
  s.homepage = %q{http://www.itreallymatters.net}
  s.post_install_message = %q{********************************************************************************

Thank you for installing watiRspec!

Execute "watirspec generate" under your project's directory to generate default project structure.

********************************************************************************
}
  s.rdoc_options = []
  s.require_paths = ["lib"]
  s.summary = %q{watirspec 0.0.1}

  s.add_dependency("watir")
end
