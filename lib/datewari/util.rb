# frozen_string_literal: true

module Datewari
  class Util
    class << self
      def parse_date(date)
        if date.is_a?(String)
          Date.parse(date)
        else
          date
        end
      rescue => e
        nil
      end
    end
  end
end
