# encoding: utf-8
require_relative '../rim'

Rim.after_setup do
  namespace :version do
    changelog = filelist(/^Changelog/i).first
    fail 'No Changelog file found' unless changelog
    if feature_loaded? 'rim/gem'
      desc "Check if version in #{gemspec_file} is equal to version in #{changelog}."
    end
    task :check do
      version_re = /^(\d+\.\d+(?:\.\d+)+(?:\.?\S+)?)/
      # changelog
      line = File.open(changelog) do |f|
        f.readline
      end
      version = gemspec.version.to_s
      if line =~ version_re
        if $1 != version
          fail "Version mismatch (#{changelog}: #$1, #{gemspec_file}: #{version})"
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
    task :prepare_release => 'version:check'
    task :release => 'version:check'
  end
end
