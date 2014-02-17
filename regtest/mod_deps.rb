# -- encoding: utf-8 --
require 'regtest'
require 'fileutils'
require 'tmpdir'

RakefileHeader = <<-END
require 'rim'
END

RakefileFooter = <<-END

Rim.setup do
  name 'xxx'
  version '0.0.1'
end
END

lib_path = File.expand_path('lib')

Dir['lib/rim/*.rb'].each do |fn|
  next if fn =~/rimrc/
  Regtest.sample fn do
    Dir.chdir(Dir.tmpdir) do
      FileUtils.mkdir_p('test')
      FileUtils.touch('test/test.rb')
      File.open('Rakefile', 'w') do |f|
        f.write RakefileHeader
        mod = File.basename(fn, '.rb')
        f.write "require 'rim/#{mod}'\n"
        f.write RakefileFooter
      end
      `rake -I #{lib_path} -P -- SELFTEST=true`
    end
  end
end
