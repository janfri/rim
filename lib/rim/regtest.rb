# encoding: utf-8
require_relative '../rim'

require 'regtest/task'

class Rim
  # ALL regtest files incl. sample files, results files
  # and maybe other files (default: <tt>REGTEST_FILES</tt>)
  attr_accessor :regtest_files

  # Sample files (Ruby files) for regtest (default: <tt>REGTEST_FILES_RB</tt>)
  attr_accessor :regtest_files_rb

  # Flag if task regtest is invoked before releasing this means it is a
  # precondition for tasks prepare_release and release (default: <tt>true</tt>)
  attr_accessor :run_regtest_before_release
end

Rim.defaults do
  regtest_files_rb ::REGTEST_FILES_RB
  regtest_files ::REGTEST_FILES
  run_regtest_before_release true
end

Rim.after_setup do
  if regtest_files_rb != REGTEST_FILES_RB
    (::REGTEST_FILES_RB.clear << regtest_files_rb).flatten!
  end
  if regtest_files != REGTEST_FILES
    (::REGTEST_FILES.clear << regtest_files).flatten!
  end
  if feature_loaded? 'rim/release'
    if run_regtest_before_release
      task :prepare_release => :regtest
      task :release => :regtest
    end
  end
end
