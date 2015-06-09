require 'spec_helper'

module Stats
  describe Distribution do
    # TODO: Add tests for various means and standard deviations
    # TODO: Try to integrate some sort of Quicktest
    describe "#normal_pdf" do
      # In R:
      # dnorm(c(1, 0.5, 0.25, 0.125), mean=0, sd=1)
      # => [1] 0.2419707 0.3520653 0.3866681 0.3958377
      it "calculates the correct normal PDF, according to R" do
        Distribution.normal_pdf(1).should be_pseudo_equal(0.2419707)
        Distribution.normal_pdf(0.5).should be_pseudo_equal(0.3520653)
        Distribution.normal_pdf(0.25).should be_pseudo_equal(0.3866681)
        Distribution.normal_pdf(0.125).should be_pseudo_equal(0.3958377)
      end

      # In R:
      # pnorm(c(1, 0.5, 0.25, 0.125), mean=0, sd=1)
      # => [1] 0.8413447 0.6914625 0.5987063 0.5497382
      it "calculates the correct normal CDF, according to R" do
        Distribution.normal_cdf(1).should be_pseudo_equal(0.8413447)
        Distribution.normal_cdf(0.5).should be_pseudo_equal(0.6914625)
        Distribution.normal_cdf(0.25).should be_pseudo_equal(0.5987063)
        Distribution.normal_cdf(0.125).should be_pseudo_equal(0.5497382)
      end

      # dchisq(c(1, 0.5, 0.25, 0.125), df=2)
      # => [1] 0.3032653 0.3894004 0.4412485 0.4697065
      it "calculates the correct Chi Square PDF, according to R" do
        Distribution.chi_square_pdf(1, 2).should be_pseudo_equal(0.3032653)
        Distribution.chi_square_pdf(0.5, 2).should be_pseudo_equal(0.3894004)
        Distribution.chi_square_pdf(0.25, 2).should be_pseudo_equal(0.4412485)
        Distribution.chi_square_pdf(0.125, 2).should be_pseudo_equal(0.4697065)
      end

      # dchisq(c(1, 0.5, 0.25, 0.125), df=2)
      # => [1] 0.39346934 0.22119922 0.11750310 0.06058694
      it "calculates the correct Chi Square PDF, according to R" do
        Distribution.chi_square_cdf(1, 2).should be_pseudo_equal(0.39346934)
        Distribution.chi_square_cdf(0.5, 2).should be_pseudo_equal(0.22119922)
        Distribution.chi_square_cdf(0.25, 2).should be_pseudo_equal(0.11750310)
        Distribution.chi_square_cdf(0.125, 2).should be_pseudo_equal(0.06058694)
      end
    end
  end
end
