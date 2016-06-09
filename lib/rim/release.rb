# -- encoding: utf-8 --
Rim.after_setup do
  if version
    desc "Release version #{version}"
  end
  task :prepare_release
  task :release
end
