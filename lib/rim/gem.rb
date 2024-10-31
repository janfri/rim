# encoding: utf-8

Rim.after_setup do

  require 'rubygems/package'

  name = gemspec.name
  version = gemspec.version
  gem_file = "pkg/#{name}-#{version}.gem"

  directory 'pkg'

  CLOBBER.include(FileList['pkg'].existing)

  desc "Build the gem file #{gem_file}"
  task :gem => 'gem:build'

  namespace :gem do

    file gem_file => ['pkg', gemspec_file] do
      sh "gem build #{gemspec_file} -o #{gem_file}"
    end

    task :build => [:test, gem_file]

    desc "Show files included and files not included in gem"
    task :files do
      gemspec_files = Rim.instance.gemspec.files
      all_files = filelist('**/*') + filelist('**/.*')
      all_files.select! {|fn| File.file?(fn)}
      puts '===== Files included in gem: =====', gemspec_files.sort.join("\n")
      puts
      puts '=== Files NOT included in gem: ===', (all_files - gemspec_files).sort.join("\n")
    end

    desc "Push the gem #{name} version #{version} to rubygems.org"
    task :push => :gem do
      sh "gem push #{gem_file}"
    end

  end

  desc "Install version #{version}"
  task :install => :gem do
    sh "gem install #{gem_file}"
  end

  desc "Uninstall version #{version}"
  task :uninstall do
    sh "gem uninstall --version #{version} #{name}"
  end

  if feature_loaded? 'rim/release'
    task :release => 'gem:push'
  end

end
