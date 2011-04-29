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
      end
    end
  end
end
