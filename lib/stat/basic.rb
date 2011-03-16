module Stat
  module Basic
    def arithmetic_mean(values)
      values.reduce(&:+) / values.length
    end
    alias_method :mean, :arithmetic_mean

    def geometric_mean(values)
      values.reduce(&:*) ** (1.0/values.length)
    end
    
    def median(values)
      n = values.length
      if n.odd? 
        values.sort[n / 2]
      else
        index = n / 2 - 1
        mean values.sort[index, 2]
      end
    end

    def mode(values)
      # Maybe there's a better way to do this...
      values.sort.
        group_by {|i| i }.
        max_by {|k,v| v.length }.
        first
    end

    def variance(values, type=:population)
      n = type == :population ? values.length : values.length - 1
      mean = mean values
      1.0 / n * values.reduce {|x| (x - mean) ** 2 }
    end

    def std(values, type=:population)
      Math.sqrt variance(values, type)
    end

    def stderr(values)
      n = values.length
      std(values, :sample) / sqrt(n)
    end
    alias :sem, :stderr

    def relative_stderr(values)
      stderr(values) / mean(values) * 100
    end
    alias :rse, :relative_stderr

    def coefficient_of_variation(values, type=:population)
      std(values, type) / mean(values) * 100
    end
    alias :cv, :coefficient_of_variation
  end
end
