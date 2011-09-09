# -- encoding: utf-8 --
class Rim
  # Gem version
  attr_accessor :version

  # Project / gem description
  attr_accessor :description

  # Project / gem summary
  attr_accessor :summary

  # E-Mail address
  attr_accessor :email

  # Project homepage
  attr_accessor :homepage

  # Files included in the gem (default: <code>/^README/i, /^Changelog/i, /^COPYING/i, /^LICENSE/i, 'lib/**/*', 'test/**/*'</code>)
  attr_accessor :gem_files
end

Rim.defaults do
  gem_files filelist(/^README/i, /^Changelog/i, /^COPYING/i, /^LICENSE/i, 'lib/**/*', 'test/**/*')
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
    spec = Gem::Specification.new do |s|
      s.authors = authors
      s.email = email
      s.platform = Gem::Platform::RUBY
      s.description = description
      s.homepage = homepage
      s.name = name
      s.summary = summary
      s.version = version
      s.require_path = lib_dir
      s.files = gem_files
    end

    task_object = klass.new(spec) do |pkg|
    end

    desc 'Push the gem to rubygems.org'
    task :release => [:test, :gem] do
      gem_filename = format('%s/%s.gem', task_object.package_dir, task_object.name)
      puts "Push #{gem_filename} to rubygems.org"
      system "gem push #{gem_filename}"
    end
  end

end
