# -- encoding: utf-8 --
Rim.after_setup do
  desc 'Start a ripl session an loading lib'
  task :ripl do
    i_params = Array(require_paths).map {|e| '-I ' << e}.join(' ')
    sh "ripl #{i_params} -r #{name}"
  end
end
