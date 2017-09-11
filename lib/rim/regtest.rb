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
    development_dependencies << %w(regtest ~>1.0)
  end
end
