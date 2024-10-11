# encoding: utf-8
Rim.after_setup do
  desc 'Prints informations about the Rim object.'
  task :info do
    require 'yaml'
    info = {}
    Rim.instance.instance_variables.sort.each do |attr|
      name = attr.to_s.sub(/^@/, '')
      val = send(name)
      if val.kind_of? FileList
        val = val.to_a
      end
      info[name] = val
    end
    puts info.to_yaml
  end
end
