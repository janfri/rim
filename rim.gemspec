# encoding: utf-8
$:.unshift 'lib'
require 'rim'

Gem::Specification.new do |s|
  s.name = 'rim'
  s.version = Rim::VERSION

  s.authors = 'Jan Friedrich'
  s.description = "Goal is to have a project managing that just works on as many Ruby\nversions as possible and is easy to extend. Feel free to dislike it. ;)\n"
  s.email = 'janfri26@gmail.com'
  s.files = %w[Changelog LICENSE README.md] + Dir['lib/**/*.rb']
  s.homepage = 'https://github.com/janfri/rim'
  s.licenses = 'MIT'
  s.summary = 'A simple project / gem manager'

  s.required_ruby_version = '>= 2.4.0'

  s.add_development_dependency 'rake', '>= 0'
  s.add_development_dependency 'test-unit', '~> 3'
  s.add_development_dependency 'regtest', '~> 2'
end
