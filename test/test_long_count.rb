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
end
