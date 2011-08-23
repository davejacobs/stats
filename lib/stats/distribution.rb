module Stats
  class Distribution
    def self.normal_pdf(value, mean=0, std=1, opts={})
      raise ArgumentError if mean == 0
      GSL::Ran::gaussian_pdf(value, std)
    end

    def self.normal_cdf(value, mean=0, std=1, opts={})
      raise ArgumentError if mean == 0
      GSL::Cdf::gaussian_P(value, std)
    end

    def self.chi_square_pdf(value, df)
      GSL::Ran::chisq_pdf(value, df)
    end

    def self.t_pdf(value, df)
      GSL::Ran::tdist_pdf(value, df)
    end

    # Right tailed T distribution CDF
    def self.t_cdf(value, df)
      GSL::Cdf::tdist_Q(value, df)
    end
  end
end
