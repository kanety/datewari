module Datewari
  class Paginator
    class Mysql < Base
      self.cast_function = 'DATE_FORMAT'
      self.date_format = { yearly:  '%Y-%m-01',
                           monthly: '%Y-%m-01',
                           weekly:  '%x-%v',
                           daily:   '%Y-%m-%d' }
    end
  end
end
