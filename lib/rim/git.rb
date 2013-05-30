# -- encoding: utf-8 --
require 'rim/release'

class Rim
  # Git push commands (default: <tt>['--tags origin master']</tt>)
  attr_accessor :git_push_commands
end

Rim.defaults do
  git_push_commands ['--tags origin master']
end

Rim.after_setup do
  if File.exist?('.git') && File.directory?('.git')
    tag_name = "v#{version}"
    namespace :git do
      desc "Create git tag #{tag_name}"
      tag_task = task :tag do
        cmd = "git tag #{tag_name}"
        sh cmd
      end
      desc 'Check if git tree is clean'
      task :check do
        res = `git status --porcelain`
        unless res.empty?
          raise 'Git tree is not clean'
        end
      end
      desc 'Push master to git remotes'
      task :push => :check do
        git_push_commands.each do |cmd|
          sh "git push #{cmd}"
        end
      end
    end
    task :release => 'git:check' do
      invoke 'git:tag'
    end
  end
end
