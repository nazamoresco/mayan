# frozen_string_literal: true

module Mayan
  class Haab
    class Date
      attr_reader :number, :glyph

      def initialize(number, glyph)
        glyph = case glyph
                when Glyph
                  glyph
                when String
                  Glyph.new(glyph)
                else
                  raise ArgumentError, "glyph must be a Haab::Glyph or String"
                end

        max_day = glyph.name == "Wayeb'" ? 4 : 19

        unless number.between?(0, max_day)
          raise ArgumentError, "number must be between 0 and #{max_day} for #{glyph.name}"
        end

        @number = number
        @glyph = glyph
      end

      def to_s
        "#{@number} #{@glyph.name}"
      end
    end
  end
end
