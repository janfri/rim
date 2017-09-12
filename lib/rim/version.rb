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
      version_re = /^(\d+\.\d+(?:\.\d+)+(?:\.?\S+)?)/
      # changelog
      line = File.open(changelog) do |f|
        f.readline
      end
      if line =~ version_re
        if $1 != version
          fail "Version mismatch (#{changelog}: #$1, Rim#version: #{version})"
        end
      else
        fail "No version information in #{changelog}"
      end
      if feature_loaded? 'rim/gem'
        # gemspec
        fail 'No gemspec file found' unless File.exist? gemspec_file
        spec = eval File.read(gemspec_file)
        unless spec.version
          fail "No version information in #{gemspec_file}"
        end
        if version != spec.version.to_s
          fail "Version mismatch (#{gemspec_file}: #{spec.version}, Rim#version: #{version})\nTry rake gem:spec"
        end
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
