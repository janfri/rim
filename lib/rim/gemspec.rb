# encoding: utf-8

class Rim

  def gemspec_file
    @gemspec_file ||= Dir['*.gemspec'].first or fail 'no gemspec file found'
  end

  def gemspec
    @gemspec ||= eval(File.read(gemspec_file), binding, gemspec_file)
  end

end
