# encoding: utf-8
require_relative '../rim'

Rim.after_setup do
  task :check_version do
    fail "Task check_version is obsolete, use version:check!"
  end
  if feature_loaded? 'rim/gem'
    task :gem => 'version:check'
  end
  if feature_loaded? 'rim/release'
    task :prepare_release => 'version:check'
    task :release => 'version:check'
  end
end
