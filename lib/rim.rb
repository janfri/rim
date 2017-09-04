# -- encoding: utf-8 --
require 'rake'
require 'rake/clean'
require 'singleton'

# == Rim a super simple ruby project / gem manager
#
# Goal is to have a project managing that just works on many Ruby
# versions as possible and is easy to extend. Feel free to dislike it. ;)
class Rim

  VERSION = '2.13.0'

  begin
    require 'rake/dsl_definition'
    include Rake::DSL
  rescue LoadError
  end
  include Singleton

  # Setting the default values of attributes. Useful when writing Rim
  # extensions.
  # The block is evaluated in Rim.instance when no parameter is used.
  # Otherwise the method yields Rim.instance.
  def self.defaults(&blk)
    rim = Rim.instance
    if blk.arity < 1
      rim.instance_eval(&blk)
    else
      yield rim
    end
  end

  # Setting up Rim. This method is usual used in Rakefiles to setting
  # the project specific values of the Rim instance.
  # The block is evaluated in Rim.instance when no parameter is used.
  # Otherwise the method yields Rim.instance.
  def self.setup(&blk)
    rim = Rim.instance
    if blk.arity < 1
      rim.instance_eval(&blk)
    else
      yield rim
    end
    execute_definitions
  end

  # The block is executed after setup is completed.
  # Useful when writing rim extensions.
  # At execution time the Rim instance is complete initialized.
  def self.after_setup(&blk)
    @definitions << blk
  end

  # Invoke task +name+ if defined raise an error otherwise.
  def invoke name
    Rake::Task[name].invoke
  end

  # Helper method to generate Rake::FileList objects.
  # Main difference between Rake::FileList.new and this method is
  # the possibility to use Regexp objects as parameters.
  def filelist(*args)
    res = FileList.new
    args.each do |arg|
      if arg.kind_of?(Regexp)
        res += FileList.new('**/*').grep(arg)
      else
        res += FileList.new(arg)
      end
    end
    res
  end

  # Helper method to check if a module is already required
  # Example: feature_loaded?('rim/release')
  def feature_loaded? name
    ! $LOADED_FEATURES.grep(%r((^|/)#{name}\.rb$)).empty?
  end

  private

  def self.attr_accessor attr
    public
    attr_writer attr
    self.class_eval "def #{attr}(arg=nil); arg.nil? ? @#{attr} : @#{attr} = arg; end"
    private
  end

  @definitions = []

  def self.execute_definitions
    @definitions.each do |blk|
      Rim.instance.instance_eval(&blk)
    end
  end

end

require 'rim/core'
require 'rim/rimrc' unless ENV['SELFTEST']
