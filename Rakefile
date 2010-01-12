require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "whatismyip"
    gem.summary = %Q{The simple way to check your ip addresses from the command line}
    gem.description = %Q{Lets you check your public and local ip addresses by simply typing 'whatismyip' on the command-line}
    gem.email = "jimmybaker@me.com"
    gem.homepage = "http://github.com/jumzies/whatismyip"
    gem.authors = ["Jimmy Baker"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_dependency "nokogiri", ">=0"
    gem.post_install_message = "Now simply type 'whatismyip'.."
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
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
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "whatismyip #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
