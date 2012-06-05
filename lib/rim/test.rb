# -- encoding: utf-8 --
class Rim
  # Test files (default: <code>'test/\*\*/\*.rb')</code>
  attr_accessor :test_files

  # Require dirs for tests (default: <code>%w(lib test)</code>)
  attr_accessor :test_require_paths
end

Rim.defaults do
  test_files filelist('test/**/*.rb')
  test_require_paths %w(lib test)
end

Rim.after_setup do
  unless Array(test_files).empty?
    require 'rake/testtask'
    Rake::TestTask.new do |t|
      t.test_files = test_files
      t.libs << test_require_paths
    end
    task :default => :test
  end
end
