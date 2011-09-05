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
end

Rim.defaults do
  self.version = '1.0'
end

Rim.after_setup do
  begin
    require 'rubygems/package_task'
    klass = Gem::PackageTask
  rescue LoadError
    require 'rake/gempackagetask'
    klass = Rake::GemPackageTask
  end

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
    s.files = lib_dir
  end

  klass.new(spec) do |pkg|
    pkg.need_zip = true
    pkg.need_tar = true
  end

end
