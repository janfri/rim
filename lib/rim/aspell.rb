# -- encoding: utf-8 --
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
  namespace :aspell do
    desc 'Test if there are no spellcheck errors'
    task :check do
      error_files = []
      aspell_files.each do |fn|
        unless `aspell list -l #{aspell_lang} < #{fn}`.empty?
          error_files << fn
        end
      end
      fail "There are spelling errors in #{error_files.join(', ')}" unless error_files.empty?
    end
  end
  if feature_loaded 'rim/release'
    task :release => 'aspell:check'
  end
end
