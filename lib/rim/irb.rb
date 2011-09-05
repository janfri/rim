Rim.after_setup do
  desc 'Start an irb session an loading lib'
  task :irb do
    lib_dir = Rim.instance.lib_dir
    name = Rim.instance.name
    exec = "irb -I #{lib_dir} -r #{name}"
  end
end
