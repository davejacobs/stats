module Stat
  module Basic
    def arithmetic_mean(values)
      values.reduce(&:+) / values.length
    end
    alias_method :mean, :arithmetic_mean

    def geometric_mean(values)
      values.reduce(&:*) ** (1/values.length.to_f)
    end
    
    def median(values)
      length = values.length
      if length.odd? 
        values.sort[length / 2]
      else
        index = length / 2 - 1
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
  end
end
