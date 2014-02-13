# -- encoding: utf-8 --
require 'rim/release'

class Rim
  # Files to check via aspell (default: /^README/i)
  attr_accessor :aspell_files

  # Language for aspell (default: 'en')
  attr_accessor :aspell_lang
end

Rim.defaults do
  aspell_files filelist(/^README/i)
  aspell_lang 'en'
end

Rim.after_setup do
  desc 'Check files via aspell'
  task :aspell do
    aspell_files.each do |fn|
      sh "aspell -c -x -l #{aspell_lang} #{fn}"
    end
  end
end
