# -- encoding: utf-8 --
require 'regtest/task'

class Rim
  # ALL regtest files incl. sample files, results files
  # and maybe other files (default: <tt>REGTEST_FILES</tt>)
  attr_accessor :regtest_files

  # Sample files (Ruby files) for regtest (default: <tt>REGTEST_FILES_RB</tt>)
  attr_accessor :regtest_files_rb
end

Rim.defaults do
  regtest_files_rb ::REGTEST_FILES_RB
  regtest_files ::REGTEST_FILES
end

Rim.after_setup do
  if feature_loaded? 'rim/gem'
    self.gem_files += regtest_files
    unless development_dependencies.flatten.include? 'regtest'
      begin
        require 'regtest/version'
        v = Regtest::VERSION.sub(/\.\d+(?:\.?\w+)?$/, '')
        development_dependencies << %W(regtest ~>#{v})
      rescue LoadError
        development_dependencies << %w(regtest ~>1.0)
      end
    end
  end
  if regtest_files_rb != REGTEST_FILES_RB
    (::REGTEST_FILES_RB.clear << regtest_files_rb).flatten!
  end
  if regtest_files != REGTEST_FILES
    (::REGTEST_FILES.clear << regtest_files).flatten!
  end
end
