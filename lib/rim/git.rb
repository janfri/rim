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
      desc 'Check if git tree is clean'
      task :check do
        res = `git status`
        if res !~ /nothing to commit/
          raise 'Git tree is not clean'
        end
      end
    end
    task :release => 'git:check' do
      invoke 'git:tag'
    end
  end
end
