# encoding: utf-8
require 'regtest'

`rake clobber`
`rake -T`.split(/\n/).map {|line| line.split(/#/).first.strip}.each do |cmd|
  next if cmd =~ /(regtest)|(irb)|(pry)|(ripl)/
  cmd.sub! /rake/, 'rake -n'
  Regtest.sample cmd do
    res = `#{cmd} 2>&1`.gsub %r{(?<=pkg/rim-)(.+)(?=\.gem)}, 'x.x.x'
    res.split(/\n/).grep(/Execute/)
  end
end



