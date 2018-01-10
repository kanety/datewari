module Datewari
  module Paginator
    class Mysql < Base
      private

      def pages_for_yearly
        @query.pluck_dates('DATE_FORMAT', '%Y-%m-01')
              .map { |date| Date.parse(date) }
      end

      def pages_for_monthly
        @query.pluck_dates('DATE_FORMAT', '%Y-%m-01')
              .map { |date| Date.parse(date) }
      end

      def pages_for_weekly
        @query.pluck_dates('DATE_FORMAT', '%x-%v')
              .map { |date| Date.commercial(*date.split('-').map(&:to_i)) }
      end

      def pages_for_daily
        @query.pluck_dates('DATE_FORMAT', '%Y-%m-%d')
              .map { |date| Date.parse(date) }
      end
    end
  end
end
