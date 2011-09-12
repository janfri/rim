# -- encoding: utf-8 --
require 'rim/release'

Rim.after_setup do
  if Dir.exist?('.git')
    tag_name = "v#{version}"
    namespace :git do
      desc "Create git tag #{tag_name}"
      tag_task = task :tag do
        cmd = "git tag #{tag_name}"
        puts cmd
        sh cmd
      end
    end
    task :release do
      invoke 'git:tag'
    end
  end
end
