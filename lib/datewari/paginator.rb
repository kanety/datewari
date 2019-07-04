require_relative 'paginator/base'

module Datewari
  module RelationMethods
    attr_accessor :paginator
  end

  module Extension
    def date_paginate(column, order, options = {})
      options[:scope] ||= :monthly

      rel = self.all
      paginator = Paginator.new(rel, column, order, options)

      rel = paginator.paginate
      rel = rel.extending RelationMethods
      rel.paginator = paginator
      rel
    end
  end

  class Paginator
    attr_accessor :scope, :date

    def initialize(rel, column, order, options)
      @scope = options[:scope].to_sym

      @query = case rel.klass.connection.adapter_name
               when 'PostgreSQL'
                 require_relative 'paginator/postgresql'
                 Postgresql.new(rel, column, order, options)
               when 'PostGIS'
                 require_relative 'paginator/postgresql'
                 Postgresql.new(rel, column, order, options)
               when 'Mysql2'
                 require_relative 'paginator/mysql'
                 Mysql.new(rel, column, order, options)
               else
                 raise ArgumentError.new("Unsupported adapter: #{rel.klass.connection.adapter_name}")
               end

      @date = Util.parse_date(options[:date]) || pages.first || Date.today
    end

    def pages
      @pages ||= @query.pages
    end

    def paginate
      @query.paginate(*date_range)
    end

    def total_entries
      @total_entries ||= @query.total_entries
    end

    def current_entries
      @current_entries ||= paginate.count
    end

    def date_range
      @date_range ||= send("date_range_for_#{@scope}")
    end

    def current_index
      @current_index ||= if pages.empty?
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
  end
end
