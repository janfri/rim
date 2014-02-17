# -- encoding: utf-8 --
require 'rim'
require 'test/unit'

class TestHelperMethods < Test::Unit::TestCase

  class  ::Rim
    attr_accessor :some_new_attr
  end

  def setup
    @rim = Rim.instance
  end

  def test_attr_accessor
    assert_nil @rim.some_new_attr, 'New attribute must be nil.'
    @rim.some_new_attr = :standard_setter
    assert_equal :standard_setter, @rim.some_new_attr
    @rim.some_new_attr :advanced_setter
    assert_equal :advanced_setter, @rim.some_new_attr
  end

  def test_filelist
    fl = @rim.filelist(/^rakefile/i, 'lib')
    assert_equal %w(Rakefile lib), fl.to_a
  end

  def test_feature_loaded
    assert_equal false, @rim.feature_loaded?('et/http')
    assert_equal false, @rim.feature_loaded?('net/htt')
    assert_equal false, @rim.feature_loaded?('net/http')
    require 'net/http'
    assert_equal false, @rim.feature_loaded?('et/http')
    assert_equal false, @rim.feature_loaded?('net/htt')
    assert_equal true, @rim.feature_loaded?('net/http')
  end

  require 'rake'
  require 'rake/dsl_definition'
  include Rake::DSL

  def test_prepend_dep
    t = task :a => :b
    @rim.prepend_dep :c, :a
    assert_equal [:c, :b], task(:a).prerequisites.map {|e| e.to_sym}
  end

end
