# frozen_string_literal: true

module Mayan
  class Haab
    class Glyph
      attr_reader :name

      def initialize(name)
        unless GLYPHS.include?(name)
          raise ArgumentError, "name must be one of the 19 Haab month names"
        end

        @name = name
      end
    end
  end
end
