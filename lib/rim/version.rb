# -- encoding: utf-8 --
Rim.after_setup do
  namespace :version do
    changelog = filelist(/^Changelog/i).first
    desc "Check if version in #{changelog} is equal to Rim#version."
    task :check do
      line = File.open(changelog) do |f|
        f.readline
      end
      if line =~ /^(\d+\.\d+(?:\.\d+)+)/
        if $1 != version
          fail "Version error (#{changelog}: #$1, Rim#version: #{version})"
        end
      else
        fail "No version information in #{changelog}"
      end
    end
  end
  if feature_loaded? 'rim/gem'
    task 'gem:push' => 'version:check'
  end
  if feature_loaded? 'rim/release'
    task :release => 'version:check'
  end
end
