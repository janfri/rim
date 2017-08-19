# -- encoding: utf-8 --
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

  # Files included in the gem (default: <code>/^README/i, /^Changelog/i, /^COPYING/i, /^LICENSE/i, /^Rakefile/i, /^Gemfile$/, '*.gemspec', 'bin/*', 'lib/**/*', 'test/**/*'</code>)
  attr_accessor :gem_files

  # Dependencies of the gem
  attr_accessor :dependencies

  # Dependencies for development (default: <code>[%W(rim ~>#{Rim::VERSION.split(/\./)[0..1].join('.')})]</code>)
  attr_accessor :development_dependencies

  # Required Ruby version
  attr_accessor :ruby_version

  # Installation message
  attr_accessor :install_message

  # Requirements (external to rubygems)
  attr_accessor :requirements

  protected

  def gem_spec
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
      s.require_paths = Array(require_paths)
      s.files = Array(gem_files)
      s.required_ruby_version = ruby_version if ruby_version
      s.post_install_message = install_message
      s.requirements = Array(requirements)
      Array(dependencies).each do |dep|
        s.add_dependency *Array(dep)
      end
      Array(development_dependencies).each do |dep|
        s.add_development_dependency *Array(dep)
      end
    end
    disclaimer = <<-END
    #
    # This file is automatically generated by rim.
    # PLEASE DO NOT EDIT IT DIRECTLY!
    # Change the values in Rim.setup in Rakefile instead.

    END
    disclaimer.gsub!(/^\s+/, '')
    spec_string = spec.to_ruby.gsub(/([)>"])\.freeze\b/, '\1')
    spec_string.sub(/^$/, disclaimer)
  end

  def gemspec_file
    "#{name}.gemspec"
  end

end

Rim.defaults do
  gem_files filelist(/^README/i, /^Changelog/i, /^COPYING/i, /^LICENSE/i, /^Rakefile/i, /^Gemfile$/, '*.gemspec', 'bin/*', 'lib/**/*', 'test/**/*')
  development_dependencies [%W(rim ~>#{Rim::VERSION.split(/\./)[0..1].join('.')})]
  requirements []
end

Rim.after_setup do

  require 'rubygems/package'

  gem_file = "pkg/#{name}-#{version}.gem"

  directory 'pkg'

  CLOBBER.include(FileList['pkg'].existing)

  desc "Build the gem file #{gem_file}"
  task :gem => 'gem:build'

  namespace :gem do

    file gem_file => ['pkg', gemspec_file] do
      sh "gem build #{gemspec_file}"
      mv File.basename(gem_file), 'pkg'
    end

    task :build => [:spec, :test, gem_file]

    desc "Push the gem #{name} version #{version} to rubygems.org"
    task :push => :gem do
      sh "gem push #{gem_file}"
    end

    gem_files_without_gemspec = gem_files.dup
    gem_files_without_gemspec.exclude('*.gemspec')
    file gemspec_file => gem_files_without_gemspec do
      File.write(gemspec_file, gem_spec)
    end

    desc "Generate #{gemspec_file}"
    task :spec => gemspec_file

  end

  desc "Install version #{version}"
  task :install => :gem do
    sh "gem install #{gem_file}"
  end

  desc "Uninstall version #{version}"
  task :uninstall do
    sh "gem uninstall --version #{version} #{name}"
  end

  if feature_loaded? 'rim/release'
    task :release => 'gem:push'
  end

end
