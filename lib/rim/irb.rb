# -- encoding: utf-8 --
class Rim
  # Required files for irb (default: Rim#name)
  attr_accessor :irb_requires
end

Rim.after_setup do
  irb_requires name
end

Rim.after_setup do
  desc 'Start an irb session and loading lib'
  task :irb do
    i_params = Array(require_paths).map {|e| '-I ' << e}.join(' ')
    r_params = Array(irb_requires).map {|e| '-r' << e}.join(' ')
    sh "irb #{i_params} #{r_params}"
  end
end
