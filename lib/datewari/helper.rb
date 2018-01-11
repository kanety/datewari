require_relative 'helper/link_renderer'
require_relative 'helper/parts_builder'

module Datewari
  module Helper
    I18N_KEY = 'date_paginate'

    def date_paginate(rel, config = {})
      [:previous_label, :next_label, :page_gap, :link_separator,
       :yearly_format,  :monthly_format, :weekly_format, :daily_format].each do |key|
        config[key] ||= I18n.t("#{I18N_KEY}.#{key}").html_safe
      end

      [:render_previous_link, :render_next_link, :render_date_link, :render_gap].each do |key|
        config[key] = true unless config.key?(key)
      end

      config[:inner_window] ||= 4
      config[:outer_window] ||= 1
      config[:param_name] ||= :date

      content_tag :div, class: 'pagination' do
        renderer = config[:link_renderer] || LinkRenderer
        renderer.new(config, rel.paginator, self).render
      end
    end

    def date_page_entries_info(rel)
      paginator = rel.paginator
      i18n_key = "#{I18N_KEY}.page_entries_info"

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
