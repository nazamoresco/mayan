# frozen_string_literal: true

module Mayan
  class Tzolkin
    class Date
      attr_reader :number, :glyph

      def initialize(number, glyph)
        raise ArgumentError, "number must be between 1 and 13" unless number.between?(1, 13)

        @glyph = case glyph
                 when Glyph
                   glyph
                 when String
                   Glyph.new(glyph)
                 else
                   raise ArgumentError, "glyph must be a Tzolkin::Glyph or String"
                 end

        @number = number
      end

      def to_s
        "#{@number} #{@glyph.name}"
      end
    end
  end
end
