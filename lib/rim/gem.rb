# -- encoding: utf-8 --
require 'rim/install'
require 'rim/release'
class Rim
  # Project / gem description
  attr_accessor :description

  # Project / gem summary
  attr_accessor :summary

  # E-Mail address
  attr_accessor :email

  # License imformation
  attr_accessor :license

  # Project homepage
  attr_accessor :homepage

  # Files included in the gem (default: <code>/^README/i, /^Changelog/i, /^COPYING/i, /^LICENSE/i, /^Rakefile/i, 'bin/*', 'lib/**/*', 'test/**/*'</code>)
  attr_accessor :gem_files

  # Dependencies for development (default: <code>["rim ~> #{Rim::VERSION.split(/\./)[0..1].join('.')}"]</code>)
  attr_accessor :development_dependencies

  # Required Ruby version
  attr_accessor :ruby_version

  # Installation message
  attr_accessor :install_message

  # Requirements (external to rubygems)
  attr_accessor :requirements
end

Rim.defaults do
  gem_files filelist(/^README/i, /^Changelog/i, /^COPYING/i, /^LICENSE/i, /^Rakefile/i, 'bin/*', 'lib/**/*', 'test/**/*')
  development_dependencies ["rim ~> #{Rim::VERSION.split(/\./)[0..1].join('.')}"]
  requirements []
end

Rim.after_setup do
  klass = nil
  begin
    require 'rubygems/package_task'
    klass = Gem::PackageTask
  rescue LoadError
    require 'rake/gempackagetask'
    klass = Rake::GemPackageTask
  end

  if klass
    task :gem do
      puts "Building #{name}-#{version}.gem"
    end
    spec = Gem::Specification.new do |s|
      s.authors = authors
      s.email = email
      s.platform = Gem::Platform::RUBY
      s.description = description
      s.license = license if license
      s.homepage = homepage
      s.name = name
      s.summary = summary
      s.version = version
      s.require_paths = require_paths
      s.files = gem_files
      s.required_ruby_version = ruby_version if ruby_version
      s.post_install_message = install_message
      s.requirements = Array(requirements)
      Array(development_dependencies).each do |depend|
        g, v = depend.split(' ', 2)
        s.add_development_dependency *[g, v]
      end
    end

    task_object = klass.new(spec) do |pkg|
    end

    namespace :gem do
      gem_filename = format('%s/%s.gem', task_object.package_dir, task_object.name)
      desc 'Push the gem to rubygems.org'
      task :push => [:clean, :test, :gem] do
        sh "gem push #{gem_filename}"
      end
      desc "Install #{gem_filename}"
      task :install => :gem do
        sh "gem install #{gem_filename}"
      end
      desc "Uninstall gem #{name} version #{version}"
      task :uninstall do
        sh "gem uninstall --version #{version} #{name}"
      end
    end
    task :release => :gem
    task :install => 'gem:install'
    task :uninstall => 'gem:uninstall'
  end

end
