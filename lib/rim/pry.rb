# encoding: utf-8
Rim.after_setup do
  desc 'Start a pry session and loading lib'
  task :pry do
    i_params = Array(gemspec.require_paths).map {|e| '-I ' << e}.join(' ')
    sh "pry #{i_params} -r #{gemspec.name}"
  end
end
