# frozen_string_literal: true

module Mayan
  class Tzolkin
    class Date
      attr_reader :number, :glyph

      def initialize(number, glyph)
        raise ArgumentError, "number must be between 1 and 13" unless number.between?(1, 13)
        raise ArgumentError, "glyph must be a Tzolkin::Glyph" unless glyph.is_a?(Glyph)

        @number = number
        @glyph = glyph
      end
    end
  end
end
