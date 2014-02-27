# -- encoding: utf-8 --
class Rim
  # Encoding odf spell checked files (default: 'UTF-8')
  attr_accessor :aspell_encoding

  # Files to check via aspell (default: /^README/i, /^Changelog/i)
  attr_accessor :aspell_files

  # Language for aspell (default: 'en')
  attr_accessor :aspell_lang

  # File to store the word list of the project (default: './.aspell.pws')
  attr_accessor :aspell_word_list
end

Rim.defaults do
  aspell_encoding 'UTF-8'
  aspell_files filelist(/^README/i, /^Changelog/i)
  aspell_lang 'en'
  aspell_word_list './.aspell.pws'
end

Rim.after_setup do
  desc 'Check files via aspell'
  task :aspell do
    aspell_files.each do |fn|
      sh "aspell -c -x --encoding=#{aspell_encoding} -l #{aspell_lang} -p #{aspell_word_list} #{fn}"
    end
  end
  namespace :aspell do
    desc 'Test if there are no spellcheck errors'
    task :check do
      error_files = []
      aspell_files.each do |fn|
        unless `aspell list --encoding=#{aspell_encoding} -l #{aspell_lang} -p #{aspell_word_list} < #{fn}`.empty?
          error_files << fn
        end
      end
      fail "There are spelling errors in #{error_files.join(', ')}" unless error_files.empty?
    end
  end
  if feature_loaded? 'rim/git'
    task 'git:check' => 'aspell:check'
  end
  if feature_loaded? 'rim/release'
    task :release => 'aspell:check'
  end
end
