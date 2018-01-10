require_relative 'paginator/base'
require_relative 'paginator/query'

module Datewari
  module RelationMethods
    attr_accessor :paginator
  end

  module Paginator
    def date_paginate(column, order, options = {})
      rel = self.all

      paginator = case rel.klass.connection.adapter_name
                  when 'PostgreSQL'
                    require_relative 'paginator/postgresql'
                    Postgresql.new(rel, column, order, options)
                  when 'Mysql2'
                    require_relative 'paginator/mysql'
                    Mysql.new(rel, column, order, options)
                  else
                    raise ArgumentError.new("Unsupported adapter: #{rel.klass.connection.adapter_name}")
                  end

      rel = paginator.paginate
      rel = rel.extending RelationMethods
      rel.paginator = paginator
      rel
    end
  end
end
