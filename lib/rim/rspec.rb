# -- encoding: utf-8 --
class Rim
  # RSpec files (default: <code>'spec/**/*.rb')</code>
  attr_accessor :rspec_files

  # Require dirs for tests (default: <code>%w(lib spec)</code>)
  attr_accessor :rspec_require_paths
end

Rim.defaults do
  rspec_files filelist('spec/**/*.rb')
  rspec_require_paths %w(lib spec)
end

Rim.after_setup do
  unless Array(rspec_files).empty?
    task :rspec do
      sh "rspec -I #{rspec_require_paths.join(':')} #{rspec_files}"
    end
    task :default => :rspec
    if feature_loaded? 'rim/gem'
      task :gem => :rspec
    end
    if feature_loaded? 'rim/release'
      task :prepare_release => :rspec
      task :release => :rspec
    end
  end
end
