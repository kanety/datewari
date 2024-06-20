# frozen_string_literal: true

module Datewari
  class Paginator
    class Base
      class_attribute :cast_function, :date_format

      def initialize(rel, column, order, options)
        @rel = rel
        @column = column
        @order = order
        @scope = options[:scope]
      end

      def pages
        send("pages_for_#{@scope}")
      end

      def paginate(start_date, end_date)
        @rel.where("#{quoted_column} BETWEEN ? AND ?", start_date, end_date)
            .order(Arel.sql("#{quoted_column} #{@order.to_s.upcase}"))
      end

      def total_entries
        @rel.count
      end

      private

      def quoted_column
        table_column = if @column.to_s.include?('.')
                         @column
                       else
                         "#{@rel.klass.table_name}.#{@column}"
                       end
        @rel.klass.connection.quote_table_name(table_column)
      end

      def pages_for_yearly
        dates = pluck_dates(self.class.cast_function, self.class.date_format[:yearly])
        dates.map { |date| Date.parse(date) }
      end

      def pages_for_monthly
        dates = pluck_dates(self.class.cast_function, self.class.date_format[:monthly])
        dates.map { |date| Date.parse(date) }
      end

      def pages_for_weekly
        dates = pluck_dates(self.class.cast_function, self.class.date_format[:weekly])
        dates.map { |date| Date.commercial(*date.split('-').map(&:to_i)) }
      end

      def pages_for_daily
        dates = pluck_dates(self.class.cast_function, self.class.date_format[:daily])
        dates.map { |date| Date.parse(date) }
      end

      def pluck_dates(function, format)
        date_sql = "#{function}(#{quoted_column}, '#{format}')"
        @rel.limit(nil)
            .offset(nil)
            .group(date_sql)
            .reorder(Arel.sql("#{date_sql} #{@order}"))
            .pluck(Arel.sql(date_sql))
      end
    end
  end
end
