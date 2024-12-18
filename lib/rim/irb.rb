# encoding: utf-8
require_relative '../rim'

class Rim
  # Required files for irb (default: Rim#name)
  attr_accessor :irb_requires
end

# Use Rim.after_setup because gemspec may not yet be set in Rim.defaults
Rim.after_setup do |r|
  r.irb_requires ||= r.gemspec.name
end

Rim.after_setup do
  desc 'Start an irb session and loading lib'
  task :irb do
    i_params = Array(gemspec.require_paths).map {|e| '-I ' << e}.join(' ')
    r_params = Array(irb_requires).map {|e| '-r ' << e}.join(' ')
    sh "irb #{i_params} #{r_params}"
  end
end
