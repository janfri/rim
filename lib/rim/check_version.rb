# -- encoding: utf-8 --
Rim.after_setup do
  changelog = filelist(/^Changelog/i).first
  desc "Check version in #{changelog} with Rim#version."
  task :check_version do
  line = File.open(changelog) do |f|
    f.readline
  end
  if line =~ /^(\d+\.\d+(?:\.\d+)+)/
    if $1 != version
      fail "Version error (#{changelog}: #$1, setup: #{version})"
    end
  else
    fail "No version information in #{changelog}"
  end
  end
  if feature_loaded 'rim/release'
    task :release => :check_version
  end
end
