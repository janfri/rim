# -- encoding: utf-8 --
require 'regtest'

Regtest.sample 'rake -P' do
  `rake -P`
end
