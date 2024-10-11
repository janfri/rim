# encoding: utf-8
class Rim
  # Name of the project / gem
  attr_accessor :name

  # Authors of the project / gem
  attr_accessor :authors

  # Project / gem version
  attr_accessor :version

  # Paths for require to load the lib (default: <code>['lib']</code>
  attr_accessor :require_paths

  alias author authors
  alias author= authors=
end

Rim.defaults do |r|
  r.require_paths = ['lib']
end
