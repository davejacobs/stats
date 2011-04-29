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

      it "#chi_square_test 2" do
        stats = Significance.chi_square([44, 56], [50, 50], 1)
        stats[:statistic].should be_pseudo_equal(1.44)
        stats[:p_value].should be_pseudo_equal(0.161822)
      end

      it "#chi_square_test 3" do
        stats = Significance.chi_square([108, 92], [100, 100], 1)
        stats[:statistic].should be_pseudo_equal(1.28)
        stats[:p_value].should be_pseudo_equal(0.185933)
      end
    end
  end
end
