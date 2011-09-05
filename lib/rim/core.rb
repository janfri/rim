class Rim
  # Name of the project / gem
  attr_accessor :name

  # lib directory (default +lib+)
  attr_accessor :lib_dir

  # Authors of the project / gem
  attr_accessor :authors

  defaults do
    lib_dir 'lib'
  end
end
