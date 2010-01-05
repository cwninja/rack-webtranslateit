require "rubygems"
require "rake/gempackagetask"
require "rake/rdoctask"

task :default => :package

spec = Gem::Specification.new do |s|
  s.name              = "rack-webtranslateit"
  s.version           = "0.1.0"
  s.summary           = "Provide a web interface for updating your WebTranslateIt.com translations."
  s.author            = "Tom Lea"
  s.email             = "contrib@tomlea.co.uk"
  s.homepage          = "http://tomlea.co.uk"

  s.has_rdoc          = true
  s.extra_rdoc_files  = %w(README.markdown)
  s.rdoc_options      = %w(--main README.markdown)

  s.files             = %w(README.markdown) + Dir.glob("{lib,public,templates}/**/*")

  s.require_paths     = ["lib"]
  s.add_dependency    "sinatra"
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

Rake::RDocTask.new do |rd|
  rd.main = "README.markdown"
  rd.rdoc_files.include("README.markdown", "lib/**/*.rb")
  rd.rdoc_dir = "rdoc"
end

desc 'Clear out RDoc and generated packages'
task :clean => [:clobber_rdoc, :clobber_package]
