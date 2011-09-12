# -- encoding: utf-8 --
require 'rim/release'
Rim.after_setup do
  changelog = filelist(/^Changelog/).first
  desc "Check version in #{changelog} with Rim#version."
  task :check_version do
  line = File.open(changelog) do |f|
    f.readline
  end
  if line =~ /^(\d+\.\d+(?:\.\d+)+)/
    if $1 != version
      raise "Version error (#{changelog}: #$1, setup: #{version})"
    end
  else
    raise "No version information in #{changelog}"
  end
  end
  task :release => :check_version
end
