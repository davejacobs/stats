module Stats
  module Significance
    def self.survival_function(value)
      1.0 - Distribution.normal_cdf(value)
    end

    # TODO: Add support for two-tailed Chi square test, which will not
    # normally equal the one-tailed result times two.
    def self.chi_square(observed, expected, df=1)
      merged = observed.zip expected

      statistic = merged.reduce(0) do |mem, pair| 
        mem + (pair[0] - pair[1]) ** 2 / pair[1].to_f
      end
      
      p_value = Distribution.chi_square_pdf(statistic, df)

      # The interface I actually want:
      # Distribution::ChiSquare.pdf(statistic, :df => degrees_of_freedom)

      { :statistic => statistic, :p_value => p_value }
    end
  end
end
