# frozen_string_literal: true

require "date"

module Mayan
  class LongCount
    class Date
      attr_reader :baktun, :katun, :tun, :winal, :kin

      def initialize(baktun, katun, tun, winal, kin)
        raise ArgumentError, "kin must be between 0 and 19" unless kin.between?(0, 19)
        raise ArgumentError, "winal must be between 0 and 17" unless winal.between?(0, 17)
        raise ArgumentError, "tun must be between 0 and 19" unless tun.between?(0, 19)
        raise ArgumentError, "katun must be between 0 and 19" unless katun.between?(0, 19)

        @baktun = baktun
        @katun = katun
        @tun = tun
        @winal = winal
        @kin = kin
      end

      def days
        (@baktun * 144_000) + (@katun * 7_200) + (@tun * 360) + (@winal * 20) + @kin
      end

      def to_gregorian
        # GMT correlation constant: 0.0.0.0.0 = JDN 584283 (September 6, 3114 BCE)
        julian_day_number = 584_283 + days
        ::Date.jd(julian_day_number)
      end

      def to_tzolkin
        # 0.0.0.0.0 = 4 Ajaw in the Tzolkin calendar
        # Day number cycles 1-13, starting at 4 for day 0
        # Glyph cycles through 20 glyphs, starting at Ajaw (index 19) for day 0
        day_count = days

        tzolkin_number = ((3 + day_count) % 13) + 1
        glyph_index = (19 + day_count) % 20

        glyph = Tzolkin::Glyph.new(Tzolkin::GLYPHS[glyph_index])
        Tzolkin::Date.new(tzolkin_number, glyph)
      end

      def to_haab
        # 0.0.0.0.0 = 8 Kumk'u in the Haab calendar
        # Kumk'u is the 18th month (index 17)
        # 8 Kumk'u is 348 days into the Haab year (17 * 20 + 8)
        day_count = days

        haab_day_in_cycle = (day_count + 348) % 365

        # Convert day position to month and day
        month_index = haab_day_in_cycle / 20
        day_of_month = haab_day_in_cycle % 20

        glyph = Haab::Glyph.new(Haab::GLYPHS[month_index])
        Haab::Date.new(day_of_month, glyph)
      end
    end
  end
end
