# -- encoding: utf-8 --
require 'singleton'

# Rim a super simple ruby project / gem manager
class Rim

  begin
    require 'rake/dsl_definition'
    include Rake::DSL
  rescue LoadError
  end
  include Singleton

  # Setting the default values of attributes. Useful when writing Rim extensions.
  def self.defaults(&blk)
    Rim.instance.instance_eval &blk
  end

  # Setting up Rim. This method is usual used in Rakefiles to setting the project specific
  # values of the Rim instance.
  def self.setup(&blk)
    Rim.instance.instance_eval &blk
    execute_definitions
  end

  # The block is executed after setup is completed.
  # Useful when writing rim extensions.
  # At execution time the Rim instance is coplete initialized.
  def self.after_setup(&blk)
    @definitions << blk
  end

  private

  def self.attr_accessor attr
    attr_writer attr
    self.class_eval "def #{attr}(arg=nil); arg.nil? ? @#{attr} : @#{attr} = arg; end"
  end

  @definitions = []

  def self.execute_definitions
    @definitions.each do |blk|
      Rim.instance.instance_eval &blk
    end
  end

end

require 'rim/core'
