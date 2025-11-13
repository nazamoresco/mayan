# frozen_string_literal: true

module Mayan
  class Tzolkin
    class Glyph
      attr_reader :name

      def initialize(name)
        unless GLYPHS.include?(name)
          raise ArgumentError, "name must be one of the 20 Tzolkin day names"
        end

        @name = name
      end
    end
  end
end
