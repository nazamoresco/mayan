# frozen_string_literal: true

require "test_helper"

class TestLongCount < Minitest::Test
  def test_that_it_exists
    assert defined?(Mayan::LongCount)
  end

  def test_that_date_class_exists
    assert defined?(Mayan::LongCount::Date)
  end
end
