# frozen_string_literal: true

module Mayan
  class LongCount
    class Date
      attr_reader :baktun, :katun, :tun, :winal, :kin

      def initialize(baktun, katun, tun, winal, kin)
        @baktun = baktun
        @katun = katun
        @tun = tun
        @winal = winal
        @kin = kin
      end
    end
  end
end
