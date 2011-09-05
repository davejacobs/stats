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

    def self.repeated_measures_t(x, y)
      n = x.length
      xy_delta = (0...n).map {|i| x[i] - y[i] }

      mean = Basic.mean(xy_delta)
      variance = Basic.variance(xy_delta, :sample)

      null_hypothesis_mean = 0
      statistic = (mean - null_hypothesis_mean) / ::Math.sqrt(variance / n.to_f)
      df = n - 1
      p_value = Distribution.t_cdf(statistic, df)

      { :statistic => statistic, :p_value => p_value }
    end

    def self.one_way_anova(list)
      n = list.length
      flat_list = list.flatten
      flat_n = flat_list.length

      grand_sum = Math.sum(flat_list)
      grand_mean = grand_sum / flat_n.to_f

      total_ss = flat_list.reduce(0) do |sum, x| 
        sum + (x - grand_mean) ** 2
      end

      between_ss = list[0].length * list.reduce(0) do |sum, values|
        sum + (Basic.mean(values) - grand_mean) ** 2
      end

      within_ss = total_ss - between_ss

      df1 = n - 1.0
      df2 = flat_n - n

      statistic = between_ss / df1 * df2 / within_ss
      p_value = Distribution.f_cdf(statistic, df1, df2)
      { :statistic => statistic, :p_value => p_value }
    end
  end
end
