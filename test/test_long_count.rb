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

  def test_days_zero
    date = Mayan::LongCount::Date.new(0, 0, 0, 0, 0)
    assert_equal 0, date.days
  end

  def test_days_single_kin
    date = Mayan::LongCount::Date.new(0, 0, 0, 0, 1)
    assert_equal 1, date.days
  end

  def test_days_single_winal
    date = Mayan::LongCount::Date.new(0, 0, 0, 1, 0)
    assert_equal 20, date.days
  end

  def test_days_single_tun
    date = Mayan::LongCount::Date.new(0, 0, 1, 0, 0)
    assert_equal 360, date.days
  end

  def test_days_single_katun
    date = Mayan::LongCount::Date.new(0, 1, 0, 0, 0)
    assert_equal 7_200, date.days
  end

  def test_days_single_baktun
    date = Mayan::LongCount::Date.new(1, 0, 0, 0, 0)
    assert_equal 144_000, date.days
  end

  def test_days_mixed
    date = Mayan::LongCount::Date.new(13, 0, 0, 0, 0)
    assert_equal 1_872_000, date.days
  end

  def test_days_complex
    date = Mayan::LongCount::Date.new(1, 2, 3, 4, 5)
    # (1 * 144,000) + (2 * 7,200) + (3 * 360) + (4 * 20) + 5
    # 144,000 + 14,400 + 1,080 + 80 + 5 = 159,565
    assert_equal 159_565, date.days
  end
end
