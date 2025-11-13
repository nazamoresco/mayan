# frozen_string_literal: true

require "test_helper"

class TestLongCount < Minitest::Test
  def test_that_it_exists
    assert defined?(Mayan::LongCount)
  end

  def test_that_date_class_exists
    assert defined?(Mayan::LongCount::Date)
  end

  def test_date_initialization
    date = Mayan::LongCount::Date.new(13, 0, 0, 0, 0)
    assert_equal 13, date.baktun
    assert_equal 0, date.katun
    assert_equal 0, date.tun
    assert_equal 0, date.winal
    assert_equal 0, date.kin
  end

  def test_kin_validation
    assert_raises(ArgumentError) { Mayan::LongCount::Date.new(0, 0, 0, 0, 20) }
    assert_raises(ArgumentError) { Mayan::LongCount::Date.new(0, 0, 0, 0, -1) }
  end

  def test_winal_validation
    assert_raises(ArgumentError) { Mayan::LongCount::Date.new(0, 0, 0, 18, 0) }
    assert_raises(ArgumentError) { Mayan::LongCount::Date.new(0, 0, 0, -1, 0) }
  end

  def test_tun_validation
    assert_raises(ArgumentError) { Mayan::LongCount::Date.new(0, 0, 20, 0, 0) }
    assert_raises(ArgumentError) { Mayan::LongCount::Date.new(0, 0, -1, 0, 0) }
  end

  def test_katun_validation
    assert_raises(ArgumentError) { Mayan::LongCount::Date.new(0, 20, 0, 0, 0) }
    assert_raises(ArgumentError) { Mayan::LongCount::Date.new(0, -1, 0, 0, 0) }
  end
end
