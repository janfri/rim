# encoding: utf-8
require 'regtest'
require 'fileutils'
require 'tmpdir'

RakefileHeader = <<-END
require 'rim'
END

RakefileFooter = <<-END

Rim.setup do
end
END

Gemspec = <<-END
Gem::Specification.new do |s|
  s.name = 'xxx'
  s.version = '0.0.1'

  s.authors = 'Jan Friedrich'
  s.description = 'test'
  s.email = 'janfri26@gmail.com'
  s.files = %w[Changelog] + Dir['lib/**/*.rb']
  s.homepage = 'https://github.com/test/it'
  s.licenses = 'MIT'
  s.summary = 'test'

  s.required_ruby_version = '>= 2.4.0'
end
END

Changelog = <<-END
0.0.1
First Version
END

lib_path = File.expand_path('lib')

Dir['lib/rim/*.rb'].sort.each do |fn|
  next if fn =~/rimrc/
  Regtest.sample fn do
    Dir.mktmpdir do |tmpdir|
      Dir.chdir(tmpdir) do
        File.write 'xxx.gemspec', Gemspec
        File.write 'Changelog', Changelog
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
end
