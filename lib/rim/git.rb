# -- encoding: utf-8 --
require 'rim/release'

class Rim
  # Git remotes to push (default: <tt>origin</tt>)
  attr_accessor :git_remotes
end

Rim.defaults do
  git_remotes %w(origin)
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
        res = `git status`
        if res !~ /nothing to commit/
          raise 'Git tree is not clean'
        end
      end
      desc 'Push master to git remotes'
      task :push => :check do
        git_remotes.each do |remote|
          sh "git push #{remote} master"
        end
      end
    end
    task :release => 'git:check' do
      invoke 'git:tag'
    end
  end
end
