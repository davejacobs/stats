module Stats
  module Basic
    class << self
      def arithmetic_mean(values)
        return nil if values.empty?
        values.reduce(&:+).to_f / values.length
      end
      alias_method :mean, :arithmetic_mean

      def geometric_mean(values)
        return nil if values.empty?
        values.reduce(&:*) ** (1.0 / values.length)
      end
      
      def median(values)
        return nil if values.empty?
        n = values.length
        if n.odd? 
          values.sort[n / 2]
        else
          index = n / 2 - 1
          mean values.sort[index, 2]
        end
      end

      def mode(values)
        return nil if values.empty?

        # Maybe there's a better way to do this...
        
        identity = lambda {|x| x }
        groups = values.group_by(&identity).values
        counts = groups.group_by(&:length)
        max_count = counts.keys.sort.last
        mode = counts[max_count].map {|x| x.first }

        case mode.length
        when values.length
          nil
        when 1
          mode.first
        else
          mode
        end
      end

      def variance(values, type=:population)
        return nil if values.empty?

        n = (type == :population) ? values.length : values.length - 1
        mean = mean(values)
        1.0 / n * values.reduce(0) {|sum, x| sum + (x - mean) ** 2 }
      end

      def std(values, type=:population)
        return nil if values.empty?
        ::Math.sqrt variance(values, type)
      end

      def stderr(values)
        n = values.length
        std(values, :sample) / sqrt(n)
      end
      alias_method :sem, :stderr

      def relative_stderr(values)
        stderr(values) / mean(values) * 100
      end
      alias_method :rse, :relative_stderr

      def coefficient_of_variation(values, type=:population)
        std(values, type) / mean(values) * 100
      end
      alias_method :cv, :coefficient_of_variation
    end
  end
end
