module Stats
  module Significance
    # TODO: Add support for two-tailed Chi square test, which will not
    # normally equal the one-tailed result times two.
    def self.chi_square(observed, expected, degrees_of_freedom=1)
      merged = observed.zip expected

      statistic = merged.reduce(0) do |mem, pair| 
        mem + (pair[0] - pair[1]) ** 2 / pair[1].to_f
      end
      
      p_value = GSL::Ran::chisq_pdf(statistic, degrees_of_freedom)

      # The interface I actually want:
      # Distribution::ChiSquare.cdf(statistic, :df => degrees_of_freedom)

      { :statistic => statistic, :p_value => p_value }
    end
  end
end
