# frozen_string_literal: true

module Mayan
  class Tzolkin
    GLYPHS = [
      "Imix'",
      "Ik'",
      "Ak'bal",
      "K'an",
      "Chikchan",
      "Kimi",
      "Manik'",
      "Lamat",
      "Muluk",
      "Ok",
      "Chuwen",
      "Eb",
      "Ben",
      "Hix",
      "Men",
      "K'ib'",
      "Kaban",
      "Etz'nab'",
      "Kawak",
      "Ajaw"
    ].freeze
  end
end

require_relative "tzolkin/glyph"
require_relative "tzolkin/date"
