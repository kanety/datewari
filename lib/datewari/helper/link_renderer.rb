module Datewari
  module Helper
    class LinkRenderer
      def initialize(config, paginator, template)
        @config = config
        @paginator = paginator
        @template = template
      end

      def render
        return '' if @paginator.pages.size < 2

        parts = PartsBuilder.new(@config, @paginator).build
        parts.map { |part|
          case part
          when :prev
            prev_link if @config[:render_previous_link]
          when :next
            next_link if @config[:render_next_link]
          when :gap
            gap if @config[:render_gap]
          else
            date_link(part) if @config[:render_date_link]
          end
        }.compact.join(separator).html_safe
      end

      def prev_link
        if (date = @paginator.prev_date)
          link_to @config[:previous_label], url(date), class: 'previous_page'
        else
          content_tag :span, @config[:previous_label], class: 'previous_page disabled'
        end
      end

      def next_link
        if (date = @paginator.next_date)
          link_to @config[:next_label], url(date), class: 'next_page'
        else
          content_tag :span, @config[:next_label], class: 'next_page disabled'
        end
      end

      def date_link(date)
        if date == @paginator.current_date
          content_tag :em, date_label(date, @paginator.scope), class: 'current'
        else
          link_to date_label(date, @paginator.scope), url(date)
        end
      end

      def gap
        content_tag :span, @config[:page_gap], class: 'gap'
      end

      def separator
        content_tag :span, @config[:link_separator], class: 'separator'
      end

      def date_label(date, scope)
        date.strftime(@config["#{scope}_format".to_sym])
      end

      def date_param(date)
        date.strftime('%Y-%m-%d')
      end

      def url(date)
        date_param = if date == @paginator.pages.first
                       nil
                     else
                       date_param(date)
                     end
        url_for(@config[:param_name] => date_param)
      end

      private

      def url_for(*args)
        @template.url_for(*args)
      end

      def content_tag(*args)
        @template.content_tag(*args)
      end

      def link_to(*args)
        @template.link_to(*args)
      end
    end
  end
end
