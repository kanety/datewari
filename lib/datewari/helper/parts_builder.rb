module Datewari
  module Helper
    class PartsBuilder
      def initialize(config, paginator)
        @inner = config[:inner_window]
        @outer = config[:outer_window]
        @paginator = paginator
      end

      def build
        pages = @paginator.pages
        index = @paginator.current_index
        lefts, rights, centers = page_indices(pages, index)

        parts = [:prev]

        if lefts.size > 0 && centers.size > 0 && rights.size > 0 && lefts.last + 1 < centers.first && centers.last < rights.first - 1
          parts += lefts
          parts << :gap
          parts += centers
          parts << :gap
          parts += rights
        elsif centers.size > 0 && rights.size > 0 && centers.last < rights.first - 1
          parts += (lefts + centers).uniq
          parts << :gap
          parts += rights
        elsif lefts.size > 0 && centers.size > 0 && lefts.last + 1 < centers.first
          parts += lefts
          parts << :gap
          parts += (centers + rights).uniq
        else
          parts += (lefts + centers + rights).uniq
        end

        parts << :next

        parts.map { |part| part.is_a?(Integer) ? pages[part] : part }.compact
      end

      private

      def page_indices(pages, index)
        max = pages.size - 1
        return left_indices(@outer, max), right_indices(@outer, max), center_indices(@inner, index, max)
      end

      def left_indices(outer, max)
        if outer > 0
          (0 .. range(outer - 1, max)).to_a
        else
          []
        end
      end

      def right_indices(outer, max)
        if outer > 0
          (range(max - outer + 1, max) .. max).to_a
        else
          []
        end
      end

      def center_indices(inner, index, max)
        if inner >= 0
          (range(index - inner, max) .. range(index + inner, max)).to_a
        else
          []
        end
      end

      def range(value, max)
        if value < 0
          0
        elsif value > max
          max
        else
          value
        end
      end
    end
  end
end
