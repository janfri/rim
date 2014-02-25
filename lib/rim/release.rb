Rim.after_setup do
  if version
    desc "Release version #{version}"
  end
  task :release
end
