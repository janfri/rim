# -- encoding: utf-8 --
require 'regtest'

Regtest.sample 'rake -P' do
  `rake -P SELFTEST=true`.gsub %r{(?<=pkg/rim-)(.+)(?=\.gem)}, 'x.x.x'
end
