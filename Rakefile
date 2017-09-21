$:.unshift File.dirname(__FILE__) + '/lib'
require 'rim'
require 'rim/aspell'
require 'rim/gem'
require 'rim/git'
require 'rim/info'
require 'rim/rdoc'
require 'rim/regtest'
require 'rim/release'
require 'rim/test'
require 'rim/version'

Rim.setup do
  name 'rim'
  authors 'Jan Friedrich'
  email 'janfri26@gmail.com'
  license 'MIT'
  homepage 'https://github.com/janfri/rim'
  version Rim::VERSION
  summary 'A simple project / gem manager'
  description <<-END
Goal is to have a project managing that just works on as many Ruby
versions as possible and is easy to extend. Feel free to dislike it. ;)
  END
  development_dependencies << %w(test-unit ~>3)
  run_regtest_before_release false
end
