# -- encoding: utf-8 --
require 'regtest/task'

class Rim
  # Files to handle with regtest (default: <tt>REGTEST_FILES</tt>)
  attr_accessor :regtest_files
end

Rim.defaults do
  regtest_files ::REGTEST_FILES
end

Rim.after_setup do
  if feature_loaded? 'rim/gem'
    self.gem_files += ::REGTEST_FILES
    development_dependencies << %w(regtest ~>0.4)
  end
end
