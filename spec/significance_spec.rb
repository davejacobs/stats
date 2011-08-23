require 'spec_helper'

module Stats
  describe Significance do
    context "when calculated against one degree of freedom" do
      # All Chi Square expectations come from Wolfram Alpha
      it "#chi_square_test" do
        stats = Significance.chi_square([85, 15], [75, 25], 1)
        stats[:statistic].should be_pseudo_equal(5.33333333)
        stats[:p_value].should be_pseudo_equal(0.01200306)
      end
    end

    context "when the population is not normally or cardinally distributed" do
      it "#wilcoxon_rank_sum_test" do
        pending
        Significance.wilcoxon_rank_sum([1], [2]).should_not == 0
    describe "#one_sample_t" do
      it "calculates the correct one-sided, one-sample T value according to R" do
        x = [62, 92, 75, 68, 83, 95]
        population_mean = 70

        stats = Significance.one_sample_t(x, population_mean)
        stats[:statistic].should be_pseudo_equal(1.7053)

        # One-sided
        stats[:p_value].should be_pseudo_equal(0.07443)
      end
    end

    describe "#two_sample_t" do
      it "calculates the correct one-sided, two-sample T value according to R" do
        x = [89.2, 78.2, 89.3, 88.3, 87.3, 90.1, 95.2, 94.3, 78.3, 89.3]
        y = [79.3, 78.3, 85.3, 79.3, 88.9, 91.2, 87.2, 89.2, 93.3, 79.9]

        stats = Significance.two_sample_t(x, y)
        stats[:statistic].should be_pseudo_equal(1.09472)

        # One-sided
        stats[:p_value].should be_pseudo_equal(0.144)
      end
    end
  end
end
