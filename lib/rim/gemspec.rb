# encoding: utf-8

class Rim

  # Deprecate accessors of older Rim versions (< 3.0)
  %w(author authors bindir dependencies description development_dependencies email executables gem_files homepage install_message license name require_paths requirements ruby_version summary version).each do |attr|
    define_method attr do |*args|
      warn "WARNING: Rim accessor #{attr} is not longer supported, define the value in #{gemspec_file}"
      []
    end
    alias_method "#{attr}=", attr
  end

  def gemspec_file
    @gemspec_file ||= Dir['*.gemspec'].first or fail 'no gemspec file found'
  end

  def gemspec
    @gemspec ||= eval(File.read(gemspec_file), binding, gemspec_file)
  end

end
