# frozen_string_literal: true

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
    end
  end
end
