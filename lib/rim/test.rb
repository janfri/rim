# -- encoding: utf-8 --
class Rim
  # Test files (default: <code>'test/\*\*/\*.rb')</code>
  attr_accessor :test_files
end

Rim.defaults do
  test_files filelist('test/**/*.rb')
end

Rim.after_setup do
  unless Array(test_files).empty?
    require 'rake/testtask'
    Rake::TestTask.new do |t|
      t.test_files = test_files
    end
    task :default => :test
  end
end
