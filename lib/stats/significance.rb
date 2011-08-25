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

    def self.one_sample_t(x, population_mean)
      n = x.length
      std = Basic.std(x, :sample)
      statistic = (Basic.mean(x) - population_mean) / (std / ::Math.sqrt(n).to_f)

      df = n - 1

      # Right-tailed CDF
      p_value = Distribution.t_cdf(statistic, df)

      { :statistic => statistic, :p_value => p_value }
    end

    def self.two_sample_t(x, y)
      nx = x.length
      ny = y.length

      grand_std = ::Math.sqrt(
        ((nx - 1) * (Basic.std(x, :sample) ** 2) + 
         (ny - 1) * (Basic.std(y, :sample) ** 2)) / 
         (nx + ny - 2))

      statistic = 
        (Basic.mean(x) - Basic.mean(y)) / 
        (grand_std * ::Math.sqrt(1.0 / nx + 1.0 / ny).to_f)
      df = nx + ny - 2
      p_value = Distribution.t_cdf(statistic, df)

      { :statistic => statistic, :p_value => p_value }
    end
  end
end
