# encoding: utf-8
require_relative '../rim'

class Rim
  # Test files (default: <code>'test/**/*.rb')</code>
  attr_accessor :test_files

  # Require dirs for tests (default: <code>%w(lib test)</code>)
  attr_accessor :test_require_paths

  # Warning option for test task (default <code>true</code>)
  attr_accessor :test_warning

  # Verbose option for test task (default <code>true</code>)
  attr_accessor :test_verbose
end

Rim.defaults do
  test_files filelist('test/**/*.rb')
  test_require_paths %w(lib test)
  test_warning true
  test_verbose true
end

Rim.after_setup do
  unless Array(test_files).empty?
    require 'rake/testtask'
    Rake::TestTask.new do |t|
      t.test_files = test_files
      t.libs << test_require_paths
      t.warning = test_warning
      t.verbose = test_verbose
    end
    task :default => :test

    if feature_loaded? 'rim/gem'
      task :gem => :test
    end
    if feature_loaded? 'rim/release'
      task :prepare_release => :test
      task :release => :test
    end
  end
end
