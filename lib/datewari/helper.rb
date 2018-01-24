require_relative 'helper/link_renderer'
require_relative 'helper/parts_builder'

module Datewari
  module Helper
    def date_paginate(rel, config = {})
      [:previous_label, :next_label, :page_gap, :link_separator,
       :yearly_format,  :monthly_format, :weekly_format, :daily_format].each do |key|
        config[key] ||= I18n.t("date_paginate.#{key}").html_safe
      end

      config[:page_links] = true unless config.key?(:page_links)
      config[:inner_window] ||= 4
      config[:outer_window] ||= 1
      config[:param_name] ||= :date
      config[:params] ||= {}

      renderer = config[:renderer] || LinkRenderer
      renderer.new(config, rel.paginator, self).render
    end

    def date_page_entries_info(rel)
      paginator = rel.paginator
      i18n_key = "date_paginate.page_entries_info"

      content_tag :div, class: 'pageEntryInfo' do
        case paginator.pages.size
        when 0
          I18n.t("#{i18n_key}.single_page.zero").html_safe
        when 1
          I18n.t("#{i18n_key}.single_page.other", total: paginator.total_entries).html_safe
        else
          I18n.t("#{i18n_key}.multi_page", current: paginator.current_entries, total: paginator.total_entries).html_safe
        end
      end
    end
  end
end
