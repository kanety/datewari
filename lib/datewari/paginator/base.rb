module Datewari
  module Paginator
    class Base
      attr_accessor :scope, :date

      def initialize(rel, column, order, options)
        @scope = (options[:scope] || :monthly).to_sym
        @query = Query.new(rel, column, order)
        @date = Util.parse_date(options[:date]) || pages.first || Date.today
      end

      def paginate
        @query.paginate(*date_range)
      end

      def total_entries
        @total_entries ||= @query.total_entries
      end

      def current_entries
        @current_entries ||= @query.current_entries(*date_range)
      end

      def date_range
        @date_range ||= send("date_range_for_#{@scope}")
      end

      def pages
        @pages ||= send("pages_for_#{@scope}")
      end

      def current_index
        @current_index ||=
          if pages.empty?
            0
          elsif (i = pages.index(date_range.first.to_date))
            i
          else
            pages.size - 1
          end
      end

      def current_date
        pages[current_index]
      end

      def prev_date
        if current_index > 0
          pages[current_index - 1]
        else
          nil
        end
      end

      def next_date
        if current_index < pages.size - 1
          pages[current_index + 1]
        else
          nil
        end
      end

      private

      def date_range_for_yearly
        [@date.to_time.beginning_of_year, @date.to_time.end_of_year]
      end

      def date_range_for_monthly
        [@date.to_time.beginning_of_month, @date.to_time.end_of_month]
      end

      def date_range_for_weekly
        [@date.to_time.beginning_of_week, @date.to_time.end_of_week]
      end

      def date_range_for_daily
        [@date.to_time.beginning_of_day, @date.to_time.end_of_day]
      end

      def pages_for_yearly
      end

      def pages_for_monthly
      end

      def pages_for_weekly
      end

      def pages_for_daily
      end
    end
  end
end
