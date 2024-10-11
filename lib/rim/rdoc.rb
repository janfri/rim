# encoding: utf-8
class Rim
  # Directory for rdoc output
  attr_accessor :rdoc_dir

  # RDoc files (default: <code>/README(.rdoc)?/i</code>, <code>lib/\*\*/\*</code>)
  attr_accessor :rdoc_files

  # Main file for RDoc (default: <code>/README(.rdoc)?/i</code>)
  attr_accessor :rdoc_main
end

Rim.defaults do
  rdoc_dir 'doc'
  rdoc_files filelist(/^README(\.rdoc)?$/i, 'lib/**/*')
  rdoc_main filelist(/^README(\.rdoc)?$/i).first
end

Rim.after_setup do
  klass = nil
  begin
    require 'rdoc/task'
    klass = RDoc::Task
  rescue LoadError
    begin
      require 'rake/rdoctask'
      klass = Rake::RDocTask
    rescue LoadError
      warn 'No rdoc found!'
    rescue Exception
      warn 'No rdoc found!'
    end
  end

  if klass
    klass.new do |rd|
      rd.rdoc_dir = rdoc_dir
      rd.rdoc_files = rdoc_files
      rd.main = rdoc_main
    end
  end
end
