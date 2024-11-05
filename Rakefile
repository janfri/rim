# encoding: utf-8

$:.unshift 'lib'
ENV['SELFTEST'] = 'true'
require_relative 'lib/rim/aspell'
require_relative 'lib/rim/gem'
require_relative 'lib/rim/git'
require_relative 'lib/rim/info'
require_relative 'lib/rim/rdoc'
require_relative 'lib/rim/regtest'
require_relative 'lib/rim/release'
require_relative 'lib/rim/test'
require_relative 'lib/rim/version'

Rim.setup do
  run_regtest_before_release false
end
