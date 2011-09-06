class Rim
  # Directory for rdoc output
  attr_accessor :rdoc_dir
end

Rim.defaults do
  rdoc_dir 'doc'
end

Rim.after_setup do
  klass = nil
  begin
    gem 'rdoc'
    require 'rdoc/task'
    klass = RDoc::Task
  rescue LoadError
    require 'rake/rdoctask'
    klass = Rake::RDocTask
  end

  if klass
    klass.new do |rd|
      rd.rdoc_dir = Rim.instance.rdoc_dir
    end
  end
end
