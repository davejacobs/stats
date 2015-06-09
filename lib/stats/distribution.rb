module Stats
  class Distribution
    def self.normal_pdf(value, mean=0, std=1, opts={})
      GSL::Ran.gaussian_pdf(value, std)
    end

    def self.normal_cdf(value, mean=0, std=1, opts={})
      GSL::Cdf.gaussian_P(value, std)
    end

    def self.chi_square_pdf(value, df)
      GSL::Ran.chisq_pdf(value, df)
    end

    def self.chi_square_cdf(value, df)
      GSL.cdf_chisq_P(value, df)
    end

    def self.t_pdf(value, df)
      GSL::Ran.tdist_pdf(value, df)
    end

    # Right tailed T distribution CDF
    def self.t_cdf(value, df)
      GSL::Cdf.tdist_Q(value, df)
    end

    def self.f_pdf(value, df1, df2)
      GSL::Ran.fdist_pdf(value, df1, df2)
    end

    def self.f_cdf(value, df1, df2)
      GSL::Cdf.fdist_Q(value, df1, df2)
    end
  end
end
