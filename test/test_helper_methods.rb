# -- encoding: utf-8 --
require 'rim'
require 'test/unit'

class TestHelperMethods < Test::Unit::TestCase

  class  ::Rim
    attr_accessor :some_new_attr
  end

  def test_attr_accessor
    rim = Rim.instance
    assert_nil rim.some_new_attr, 'New attribute must be nil.'
    rim.some_new_attr = :standard_setter
    assert_equal :standard_setter, rim.some_new_attr
    rim.some_new_attr :advanced_setter
    assert_equal :advanced_setter, rim.some_new_attr
  end

  def test_filelist
    rim = Rim.instance
    fl = rim.filelist(/^rakefile/i, 'lib')
    assert_equal %w(Rakefile lib), fl.to_a
  end

end
