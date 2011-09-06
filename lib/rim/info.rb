# -- encoding: utf-8 --
Rim.after_setup do
  desc 'Prints informations about the Rim object.'
  task :info do
    require 'yaml'
    puts Rim.instance.to_yaml
  end
end
