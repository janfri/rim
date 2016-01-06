# -*- encoding: utf-8 -*-
# stub: rim 2.6.1 ruby lib
#
# This file is automatic generated by rim.
# PLEASE DO NOT EDIT IT DIRECTLY!
# Change instead the values in Rim.setup in Rakefile.

Gem::Specification.new do |s|
  s.name = "rim"
  s.version = "2.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Friedrich"]
  s.date = "2016-01-06"
  s.description = "Goal is to have a project managing that just works on many Ruby\nversions as possible and is easy to extend. Feel free to dislike it. ;)\n"
  s.email = "janfri26@gmail.com"
  s.files = ["Changelog", "LICENSE", "README.rdoc", "Rakefile", "lib/rim", "lib/rim.rb", "lib/rim/aspell.rb", "lib/rim/check_version.rb", "lib/rim/core.rb", "lib/rim/gem.rb", "lib/rim/git.rb", "lib/rim/info.rb", "lib/rim/irb.rb", "lib/rim/pry.rb", "lib/rim/rdoc.rb", "lib/rim/regtest.rb", "lib/rim/release.rb", "lib/rim/rimrc.rb", "lib/rim/ripl.rb", "lib/rim/rspec.rb", "lib/rim/test.rb", "lib/rim/tire.rb", "lib/rim/version.rb", "lib/rim/yard.rb", "regtest/execution.rb", "regtest/global_deps.rb", "regtest/mod_deps.rb", "test/test_helper_methods.rb"]
  s.homepage = "https://github.com/janfri/rim"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "A simple project / gem manager"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rim>, ["~> 2.6"])
      s.add_development_dependency(%q<regtest>, ["~> 0.4"])
    else
      s.add_dependency(%q<rim>, ["~> 2.6"])
      s.add_dependency(%q<regtest>, ["~> 0.4"])
    end
  else
    s.add_dependency(%q<rim>, ["~> 2.6"])
    s.add_dependency(%q<regtest>, ["~> 0.4"])
  end
end
