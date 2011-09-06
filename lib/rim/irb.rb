Rim.after_setup do
  desc 'Start an irb session an loading lib'
  task :irb do
    exec "irb -I #{lib_dir} -r #{name}"
  end
end
