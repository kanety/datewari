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
        min = 0
        max = pages.size - 1

        lefts = left_indices(@outer, min, max)
        rights = right_indices(@outer, min, max)
        centers = center_indices(index, @inner, min, max)

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

        parts.map { |part|
          if part.is_a?(Integer)
            pages[part]
          else
            part
          end
        }.compact
      end

      def left_indices(outer, min, max)
        if outer > 0
          (min .. range(outer - 1, min, max)).to_a
        else
          []
        end
      end

      def right_indices(outer, min, max)
        if outer > 0
          (range(max - outer + 1, min, max) .. max).to_a
        else
          []
        end
      end

      def center_indices(index, inner, min, max)
        if inner >= 0
          (range(index - inner, min, max) .. range(index + inner, min, max)).to_a
        else
          []
        end
      end

      private

      def range(value, min, max)
        if value < min
          min
        elsif value > max
          max
        else
          value
        end
      end
    end
  end
end
