# -- encoding: utf-8 --
Rim.after_setup do
  desc 'Start an irb session and loading lib'
  task :irb do
    i_params = Array(require_paths).map {|e| '-I ' << e}.join(' ')
    sh "irb #{i_params} -r #{name}"
  end
end
