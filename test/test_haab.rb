# frozen_string_literal: true

require "test_helper"

class TestHaab < Minitest::Test
  def test_that_haab_exists
    assert defined?(Mayan::Haab)
  end

  def test_that_glyphs_constant_exists
    assert defined?(Mayan::Haab::GLYPHS)
    assert_equal 19, Mayan::Haab::GLYPHS.length
  end

  def test_that_glyph_class_exists
    assert defined?(Mayan::Haab::Glyph)
  end

  def test_that_date_class_exists
    assert defined?(Mayan::Haab::Date)
  end

  def test_date_initialization_with_number_and_glyph_positionally
    glyph = Mayan::Haab::Glyph.new("Pop")
    date = Mayan::Haab::Date.new(0, glyph)
    assert_equal 0, date.number
    assert_equal glyph, date.glyph
  end

  def test_date_with_different_month
    glyph = Mayan::Haab::Glyph.new("Wo'")
    date = Mayan::Haab::Date.new(10, glyph)
    assert_equal 10, date.number
    assert_equal glyph, date.glyph
  end
end
