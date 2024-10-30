# encoding: utf-8
Rim.after_setup do
  version = gemspec.version
  if version
    desc "Prepare release version #{version}"
  end
  task :prepare_release
  if version
    desc "Release version #{version}"
  end
  task :release
end
