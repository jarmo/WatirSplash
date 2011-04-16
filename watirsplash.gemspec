# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{watirsplash}
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jarmo Pertman"]
  s.date = %q{2011-04-17}
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
     "environment.rb",
     "lib/watirsplash.rb",
     "lib/watirsplash/browser.rb",
     "lib/watirsplash/cli.rb",
     "lib/watirsplash/file_helper.rb",
     "lib/watirsplash/frameworks/firewatir.rb",
     "lib/watirsplash/frameworks/helper.rb",
     "lib/watirsplash/frameworks/watir-webdriver.rb",
     "lib/watirsplash/frameworks/watir-webdriver/chrome.rb",
     "lib/watirsplash/frameworks/watir-webdriver/firefox.rb",
     "lib/watirsplash/frameworks/watir-webdriver/ie.rb",
     "lib/watirsplash/frameworks/watir.rb",
     "lib/watirsplash/generators/migrate_project.rb",
     "lib/watirsplash/generators/new_common_project.rb",
     "lib/watirsplash/generators/new_project.rb",
     "lib/watirsplash/generators/templates/new_common_project/config.rb.tt",
     "lib/watirsplash/generators/templates/new_common_project/environment.rb",
     "lib/watirsplash/generators/templates/new_common_project/lib/common_application_helper.rb",
     "lib/watirsplash/generators/templates/new_project/.rspec",
     "lib/watirsplash/generators/templates/new_project/config.rb.tt",
     "lib/watirsplash/generators/templates/new_project/environment.rb.tt",
     "lib/watirsplash/generators/templates/new_project/spec/%formatted_name%_helper.rb.tt",
     "lib/watirsplash/generators/templates/new_project/spec/dummy_spec.rb.tt",
     "lib/watirsplash/html_formatter.rb",
     "lib/watirsplash/mini_magick_patch.rb",
     "lib/watirsplash/rspec_patches.rb",
     "lib/watirsplash/spec_helper.rb",
     "lib/watirsplash/util.rb",
     "spec/file_helper_spec.rb",
     "spec/rspec_patches_spec.rb",
     "spec/spec_helper_spec.rb",
     "spec/spec_match_array_spec.rb",
     "spec/util_spec.rb",
     "spec/watir_ie_spec.rb",
     "tags"
  ]
  s.homepage = %q{http://github.com/jarmo/WatirSplash}
  s.post_install_message = %q{*************************

Thank you for installing WatirSplash 1.2.1! Don't forget to take a look at the README and History files!

Execute `watirsplash new` under your project's directory to generate a default project structure.

*************************}
  s.rdoc_options = ["--charset=UTF-8", "--main", "README.rdoc", "--template", "hanna", "--inline-source", "--format=html"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{watirsplash 1.2.1}
  s.test_files = [
    "spec/file_helper_spec.rb",
     "spec/rspec_patches_spec.rb",
     "spec/spec_helper_spec.rb",
     "spec/spec_match_array_spec.rb",
     "spec/util_spec.rb",
     "spec/watir_ie_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, ["~> 2.5"])
      s.add_runtime_dependency(%q<thor>, ["~> 0"])
      s.add_runtime_dependency(%q<require_all>, [">= 0"])
      s.add_runtime_dependency(%q<syntax>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.5"])
      s.add_dependency(%q<thor>, ["~> 0"])
      s.add_dependency(%q<require_all>, [">= 0"])
      s.add_dependency(%q<syntax>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.5"])
    s.add_dependency(%q<thor>, ["~> 0"])
    s.add_dependency(%q<require_all>, [">= 0"])
    s.add_dependency(%q<syntax>, [">= 0"])
  end
end

