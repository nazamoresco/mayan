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

  def test_to_gregorian_epoch
    date = Mayan::LongCount::Date.new(0, 0, 0, 0, 0)
    gregorian = date.to_gregorian
    # 0.0.0.0.0 = September 6, 3114 BCE (proleptic Gregorian calendar)
    assert_equal Date.new(-3113, 9, 6), gregorian
  end

  def test_to_gregorian_13_baktun
    date = Mayan::LongCount::Date.new(13, 0, 0, 0, 0)
    gregorian = date.to_gregorian
    # 13.0.0.0.0 = December 21, 2012 (the famous "end of the world" date)
    assert_equal Date.new(2012, 12, 21), gregorian
  end

  def test_to_gregorian_modern_date
    date = Mayan::LongCount::Date.new(13, 0, 10, 0, 0)
    gregorian = date.to_gregorian
    # 13.0.10.0.0 should be 10 tuns (3600 days) after 12/21/2012
    assert_equal Date.new(2022, 10, 30), gregorian
  end

  def test_to_tzolkin_epoch
    long_count = Mayan::LongCount::Date.new(0, 0, 0, 0, 0)
    tzolkin = long_count.to_tzolkin
    # 0.0.0.0.0 = 4 Ajaw
    assert_equal 4, tzolkin.number
    assert_equal "Ajaw", tzolkin.glyph.name
  end

  def test_to_tzolkin_day_one
    long_count = Mayan::LongCount::Date.new(0, 0, 0, 0, 1)
    tzolkin = long_count.to_tzolkin
    # 0.0.0.0.1 = 5 Imix'
    assert_equal 5, tzolkin.number
    assert_equal "Imix'", tzolkin.glyph.name
  end

  def test_to_tzolkin_13_baktun
    long_count = Mayan::LongCount::Date.new(13, 0, 0, 0, 0)
    tzolkin = long_count.to_tzolkin
    # 13.0.0.0.0 = 4 Ajaw (completes exactly 7200 Tzolkin cycles)
    assert_equal 4, tzolkin.number
    assert_equal "Ajaw", tzolkin.glyph.name
  end

  def test_to_tzolkin_cycle_completes
    long_count = Mayan::LongCount::Date.new(0, 0, 1, 6, 0)
    tzolkin = long_count.to_tzolkin
    # 0.0.1.6.0 = 480 days = 4 Ajaw (480 % 260 = 220, but let's calculate)
    # ((3 + 480) % 13) + 1 = (483 % 13) + 1 = (2) + 1 = 3
    # (19 + 480) % 20 = 499 % 20 = 19 = Ajaw
    assert_equal 3, tzolkin.number
    assert_equal "Ajaw", tzolkin.glyph.name
  end
end
