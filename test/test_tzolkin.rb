# frozen_string_literal: true

require "test_helper"

class TestTzolkin < Minitest::Test
  def test_that_tzolkin_exists
    assert defined?(Mayan::Tzolkin)
  end

  def test_that_glyph_class_exists
    assert defined?(Mayan::Tzolkin::Glyph)
  end

  def test_that_date_class_exists
    assert defined?(Mayan::Tzolkin::Date)
  end

  def test_glyphs_constant_defined
    assert defined?(Mayan::Tzolkin::GLYPHS)
    assert_equal 20, Mayan::Tzolkin::GLYPHS.length
  end

  def test_glyph_with_valid_name
    glyph = Mayan::Tzolkin::Glyph.new("Imix'")
    assert_equal "Imix'", glyph.name
  end

  def test_all_valid_glyphs_can_be_created
    Mayan::Tzolkin::GLYPHS.each do |glyph_name|
      glyph = Mayan::Tzolkin::Glyph.new(glyph_name)
      assert_equal glyph_name, glyph.name
    end
  end

  def test_glyph_with_invalid_name
    assert_raises(ArgumentError) { Mayan::Tzolkin::Glyph.new("InvalidGlyph") }
    assert_raises(ArgumentError) { Mayan::Tzolkin::Glyph.new("Imix") } # Missing apostrophe
    assert_raises(ArgumentError) { Mayan::Tzolkin::Glyph.new("") }
  end

  def test_date_initialization_with_valid_number_and_glyph
    glyph = Mayan::Tzolkin::Glyph.new("Imix'")
    date = Mayan::Tzolkin::Date.new(1, glyph)
    assert_equal 1, date.number
    assert_equal glyph, date.glyph
  end

  def test_date_number_validation_lower_bound
    glyph = Mayan::Tzolkin::Glyph.new("Imix'")
    assert_raises(ArgumentError) { Mayan::Tzolkin::Date.new(0, glyph) }
    assert_raises(ArgumentError) { Mayan::Tzolkin::Date.new(-1, glyph) }
  end

  def test_date_number_validation_upper_bound
    glyph = Mayan::Tzolkin::Glyph.new("Imix'")
    assert_raises(ArgumentError) { Mayan::Tzolkin::Date.new(14, glyph) }
    assert_raises(ArgumentError) { Mayan::Tzolkin::Date.new(20, glyph) }
  end

  def test_date_with_all_valid_numbers
    glyph = Mayan::Tzolkin::Glyph.new("Imix'")
    (1..13).each do |num|
      date = Mayan::Tzolkin::Date.new(num, glyph)
      assert_equal num, date.number
    end
  end
end
