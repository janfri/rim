# encoding: utf-8
class Rim
  # Encoding of spell checked files (default: 'UTF-8')
  attr_accessor :aspell_encoding

  # Files to check via aspell (default: /^README/i, /^Changelog/i)
  attr_accessor :aspell_files

  # Language for aspell (default: 'en')
  attr_accessor :aspell_lang

  # File to store the word list of the project (default: './.aspell.pws')
  attr_accessor :aspell_word_list

  def aspell_errors? fn
    ! `aspell list --encoding=#{aspell_encoding} -l #{aspell_lang} -p #{aspell_word_list} < #{fn}`.empty?
  end

end

Rim.defaults do
  aspell_encoding 'UTF-8'
  aspell_files filelist(/^README/i, /^Changelog/i)
  aspell_lang 'en'
  aspell_word_list './.aspell.pws'
end

Rim.after_setup do
  desc 'Interactive spelling check via aspell'
  task :aspell do
    aspell_files.each do |fn|
      if aspell_errors? fn
        sh "aspell -c -x --encoding=#{aspell_encoding} -l #{aspell_lang} -p #{aspell_word_list} #{fn}"
      end
    end
  end
  namespace :aspell do
    desc 'Check if there are no spellcheck errors'
    task :check do
      error_files = []
      aspell_files.each do |fn|
        error_files << fn if aspell_errors? fn
      end
      fail "There are spelling errors in #{error_files.join(', ')}" unless error_files.empty?
    end
  end
  if feature_loaded? 'rim/git'
    task 'git:check' => 'aspell:check'
  end
  if feature_loaded? 'rim/release'
    task :prepare_release => 'aspell:check'
    task :release => 'aspell:check'
  end
  if feature_loaded? 'rim/gem'
    # FIXME Implement check?
    #gem_files << aspell_word_list
  end
end
