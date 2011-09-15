require 'rim'
Rim.after_setup do
  desc 'Install the project'
  task :install

  desc 'Uninstall the project'
  task :uninstall
end
