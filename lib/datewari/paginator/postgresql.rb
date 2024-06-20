# frozen_string_literal: true

module Datewari
  class Paginator
    class Postgresql < Base
      self.cast_function = 'TO_CHAR'
      self.date_format = { yearly:  'YYYY-01-01',
                           monthly: 'YYYY-MM-01',
                           weekly:  'IYYY-IW',
                           daily:   'YYYY-MM-DD' }
    end
  end
end
