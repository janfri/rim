# encoding: utf-8
Rim.after_setup do
  desc 'Start a ripl session and loading lib'
  task :ripl do
    i_params = Array(gemspec.require_paths).map {|e| '-I ' << e}.join(' ')
    sh "ripl #{i_params} -r #{gemspec.name}"
  end
end
