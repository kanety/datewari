module Datewari
  module Paginator
    class Query
      def initialize(rel, column, order)
        @rel = rel
        @column = column
        @order = order
      end

      def paginate(start_date, end_date)
        @rel.where("#{quoted_column} BETWEEN ? AND ?", start_date, end_date)
            .order("#{quoted_column} #{@order.to_s.upcase}")
      end

      def total_entries
        @rel.count
      end

      def current_entries(start_date, end_date)
        paginate(start_date, end_date).count
      end

      def pluck_dates(function, format)
        date_sql = "#{function}(#{quoted_column}, '#{format}')"
        @rel.group(date_sql).reorder("#{date_sql} #{@order}").pluck(date_sql)
      end

      def quoted_column
        table_column = if @column.to_s.include?('.')
                         @column
                       else
                         "#{@rel.klass.table_name}.#{@column}"
                       end
        @rel.klass.connection.quote_table_name(table_column)
      end
    end
  end
end
