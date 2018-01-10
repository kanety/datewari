module Datewari
  class Railtie < Rails::Railtie
    ActiveSupport.on_load :active_record do
      ActiveRecord::Base.send :extend, Paginator
      ActiveRecord::Relation.send :include, Paginator
    end

    ActiveSupport.on_load :action_view do
      ActionView::Base.send :include, Helper
    end

    ActiveSupport.on_load :i18n do
      I18n.load_path += Dir["#{File.expand_path('../locales', __FILE__)}/*.yml"]
    end
  end
end
