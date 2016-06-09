# -- encoding: utf-8 --
Rim.after_setup do
  namespace :version do
    changelog = filelist(/^Changelog/i).first
    fail 'No Changelog file found' unless changelog
    if feature_loaded? 'rim/gem'
      desc "Check if Rim#version is equal to version in #{changelog} and #{gemspec_file}."
    else
      desc "Check if Rim#version is equal to version in #{changelog}."
    end
    task :check do
      # changelog
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
      # gemspec
      fail 'No gemspec file found' unless File.exist? gemspec_file
      re = /s\.version ?= ['"](\d+\.\d+\.\d+.*)['"]/o
      match = File.readlines(gemspec_file).grep(re)
      case match.size
      when 1
        match[0] =~ re
        if $1 != version
          fail "Version error (#{gemspec_file}: #$1, Rim#version: #{version})\nTry rake gem:spec"
        end
      when 0
        fail "No version information in #{gemspec_file}"
      else
        fail "More than one version information in #{gemspec_file}"
      end
    end

    if feature_loaded? 'rim/release'
      task :check => 'gem:spec'
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
