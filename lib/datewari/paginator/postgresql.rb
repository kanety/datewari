module Datewari
  module Paginator
    class Postgresql < Base
      private

      def pages_for_yearly
        @query.pluck_dates('TO_CHAR', 'YYYY-01-01')
              .map { |date| Date.parse(date) }
      end

      def pages_for_monthly
        @query.pluck_dates('TO_CHAR', 'YYYY-MM-01')
              .map { |date| Date.parse(date) }
      end

      def pages_for_weekly
        @query.pluck_dates('TO_CHAR', 'IYYY-IW')
              .map { |date| Date.commercial(*date.split('-').map(&:to_i)) }
      end

      def pages_for_daily
        @query.pluck_dates('TO_CHAR', 'YYYY-MM-DD')
              .map { |date| Date.parse(date) }
      end
    end
  end
end
