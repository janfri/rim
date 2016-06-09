# -*- encoding: utf-8 -*-
# stub: rim 2.9.0 ruby lib
#
# This file is automatically generated by rim.
# PLEASE DO NOT EDIT IT DIRECTLY!
# Change instead the values in Rim.setup in Rakefile.

Gem::Specification.new do |s|
  s.name = "rim".freeze
  s.version = "2.9.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jan Friedrich".freeze]
  s.date = "2016-06-09"
  s.description = "Goal is to have a project managing that just works on many Ruby\nversions as possible and is easy to extend. Feel free to dislike it. ;)\n".freeze
  s.email = "janfri26@gmail.com".freeze
  s.files = ["Changelog".freeze, "LICENSE".freeze, "README.rdoc".freeze, "Rakefile".freeze, "lib/rim".freeze, "lib/rim.rb".freeze, "lib/rim/aspell.rb".freeze, "lib/rim/check_version.rb".freeze, "lib/rim/core.rb".freeze, "lib/rim/gem.rb".freeze, "lib/rim/git.rb".freeze, "lib/rim/info.rb".freeze, "lib/rim/irb.rb".freeze, "lib/rim/pry.rb".freeze, "lib/rim/rdoc.rb".freeze, "lib/rim/regtest.rb".freeze, "lib/rim/release.rb".freeze, "lib/rim/rimrc.rb".freeze, "lib/rim/ripl.rb".freeze, "lib/rim/rspec.rb".freeze, "lib/rim/test.rb".freeze, "lib/rim/tire.rb".freeze, "lib/rim/version.rb".freeze, "lib/rim/yard.rb".freeze, "regtest/execution.rb".freeze, "regtest/execution.yml".freeze, "regtest/global_deps.rb".freeze, "regtest/global_deps.yml".freeze, "regtest/mod_deps.rb".freeze, "regtest/mod_deps.yml".freeze, "test/test_helper_methods.rb".freeze]
  s.homepage = "https://github.com/janfri/rim".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.4".freeze
  s.summary = "A simple project / gem manager".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rim>.freeze, ["~> 2.9"])
      s.add_development_dependency(%q<regtest>.freeze, ["~> 0.4"])
    else
      s.add_dependency(%q<rim>.freeze, ["~> 2.9"])
      s.add_dependency(%q<regtest>.freeze, ["~> 0.4"])
    end
  else
    s.add_dependency(%q<rim>.freeze, ["~> 2.9"])
    s.add_dependency(%q<regtest>.freeze, ["~> 0.4"])
  end
end
