module Stats
  module Math
    def self.sum(values)
      values.reduce(0, &:+)
    end

    def self.integrate(range_or_array, &f)
      f = GSL::Function.alloc(&f)
      f.qng(range_or_array.to_a, [0, 1.0e-7]).first
    end
  end
end
