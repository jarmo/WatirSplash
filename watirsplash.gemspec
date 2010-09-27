# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{watirsplash}
  s.version = "0.2.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jarmo Pertman"]
  s.date = %q{2010-09-27}
  s.default_executable = %q{watirsplash}
  s.description = %q{WatirSplash makes testing of web applications splashin' easy by combining best features of Watir, RSpec and Ruby!}
  s.email = %q{jarmo.p@gmail.com}
  s.executables = ["watirsplash"]
  s.extra_rdoc_files = [
    "History.rdoc",
     "License.txt",
     "README.rdoc"
  ]
  s.files = [
    "History.rdoc",
     "License.txt",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/watirsplash",
     "lib/watirsplash.rb",
     "lib/watirsplash/auto_it_helper.rb",
     "lib/watirsplash/element_extensions.rb",
     "lib/watirsplash/file_helper.rb",
     "lib/watirsplash/generator.rb",
     "lib/watirsplash/html_formatter.rb",
     "lib/watirsplash/spec.rb",
     "lib/watirsplash/spec_helper.rb",
     "lib/watirsplash/util.rb",
     "lib/watirsplash/wait_helper.rb",
     "lib/watirsplash/watir.rb",
     "lib/watirsplash/watir_core.rb",
     "spec/spec.opts",
     "spec/spec_helper_spec.rb",
     "spec/spec_match_array_spec.rb",
     "spec/util_spec.rb",
     "spec/watir_element_spec.rb",
     "spec/watir_ie_spec.rb",
     "spec/watir_table_row_spec.rb",
     "spec/watir_table_spec.rb",
     "templates/common/config.rb",
     "templates/common/environment.rb",
     "templates/common/lib/common_application_helper.rb",
     "templates/project/config.rb",
     "templates/project/environment.rb",
     "templates/project/spec/application_helper.rb",
     "templates/project/spec/dummy_spec.rb",
     "templates/project/spec/spec.opts"
  ]
  s.homepage = %q{http://github.com/jarmo/WatirSplash}
  s.post_install_message = %q{*************************

Thank you for installing WatirSplash 0.2.7! Don't forget to take a look at README and History files!

Execute "watirsplash generate" under your project's directory to generate default project structure.

*************************}
  s.rdoc_options = ["--charset=UTF-8", "--main", "README.rdoc", "--template", "hanna", "--inline-source", "--format=html"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{watirsplash 0.2.7}
  s.test_files = [
    "spec/spec_helper_spec.rb",
     "spec/spec_match_array_spec.rb",
     "spec/util_spec.rb",
     "spec/watir_element_spec.rb",
     "spec/watir_ie_spec.rb",
     "spec/watir_table_row_spec.rb",
     "spec/watir_table_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<watir>, ["= 1.6.5"])
      s.add_runtime_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_runtime_dependency(%q<diff-lcs>, [">= 0"])
      s.add_runtime_dependency(%q<require_all>, [">= 0"])
      s.add_runtime_dependency(%q<rmagick>, [">= 0"])
      s.add_runtime_dependency(%q<syntax>, [">= 0"])
      s.add_runtime_dependency(%q<win32console>, [">= 0"])
      s.add_runtime_dependency(%q<win32screenshot>, [">= 0.0.4"])
    else
      s.add_dependency(%q<watir>, ["= 1.6.5"])
      s.add_dependency(%q<rspec>, ["= 1.3.0"])
      s.add_dependency(%q<diff-lcs>, [">= 0"])
      s.add_dependency(%q<require_all>, [">= 0"])
      s.add_dependency(%q<rmagick>, [">= 0"])
      s.add_dependency(%q<syntax>, [">= 0"])
      s.add_dependency(%q<win32console>, [">= 0"])
      s.add_dependency(%q<win32screenshot>, [">= 0.0.4"])
    end
  else
    s.add_dependency(%q<watir>, ["= 1.6.5"])
    s.add_dependency(%q<rspec>, ["= 1.3.0"])
    s.add_dependency(%q<diff-lcs>, [">= 0"])
    s.add_dependency(%q<require_all>, [">= 0"])
    s.add_dependency(%q<rmagick>, [">= 0"])
    s.add_dependency(%q<syntax>, [">= 0"])
    s.add_dependency(%q<win32console>, [">= 0"])
    s.add_dependency(%q<win32screenshot>, [">= 0.0.4"])
  end
end

