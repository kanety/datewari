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

        container do
          parts = PartsBuilder.new(@config, @paginator).build
          parts.map { |part|
            case part
            when :prev
              prev_link
            when :next
              next_link
            when :gap
              gap if @config[:page_links]
            else
              date_link(part) if @config[:page_links]
            end
          }.compact.join(separator).html_safe
        end
      end

      def container
        content_tag :div, class: 'pagination' do
          yield
        end
      end

      def prev_link
        if (date = @paginator.prev_date)
          link_to @config[:previous_label], url(date), class: 'previous_page', rel: 'prev'
        else
          content_tag :span, @config[:previous_label], class: 'previous_page disabled'
        end
      end

      def next_link
        if (date = @paginator.next_date)
          link_to @config[:next_label], url(date), class: 'next_page', rel: 'next'
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

      def url_for(*args, &block)
        @template.url_for(*args, &block)
      end

      def content_tag(*args, &block)
        @template.content_tag(*args, &block)
      end

      def link_to(*args, &block)
        @template.link_to(*args, &block)
      end
    end
  end
end
