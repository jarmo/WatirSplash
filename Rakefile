require 'rake'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:rcov) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.rcov = true
  t.rcov_dir = 'coverage'
  t.rcov_opts << '--sort coverage --text-summary --aggregate coverage.data'
end

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts << "--options" << "lib/spec.opts" <<
          "--require" << "lib/watirsplash/html_formatter" <<
          "--format" << "WatirSplash::HtmlFormatter:results/index.html"
end