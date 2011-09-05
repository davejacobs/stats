require 'spec_helper'

module Stats
  describe Significance do
    describe "#chi_square" do
      it "calculates the correct Chi Square stats for df = 1 according to R" do
        stats = Significance.chi_square([85, 15], [75, 25], 1)
        stats[:statistic].should be_pseudo_equal(5.33333333)
        stats[:p_value].should be_pseudo_equal(0.01200306)
      end
    end

    describe "#one_sample_t" do
      it "calculates the correct one-sided, one-sample T stats according to R" do
        x = [62, 92, 75, 68, 83, 95]
        population_mean = 70

        stats = Significance.one_sample_t(x, population_mean)
        stats[:statistic].should be_pseudo_equal(1.7053)
        stats[:p_value].should be_pseudo_equal(0.07443) # One-sided
      end
    end

    describe "#two_sample_t" do
      it "calculates the correct one-sided, two-sample T stats according to R" do
        x = [89.2, 78.2, 89.3, 88.3, 87.3, 90.1, 95.2, 94.3, 78.3, 89.3]
        y = [79.3, 78.3, 85.3, 79.3, 88.9, 91.2, 87.2, 89.2, 93.3, 79.9]

        stats = Significance.two_sample_t(x, y)
        stats[:statistic].should be_pseudo_equal(1.09472)
        stats[:p_value].should be_pseudo_equal(0.144) # One-sided
      end
    end

    describe "#repeated_measures_t" do
      it "calculates the correct one-sided, repeated-measure T stats according to R" do
        x = [65, 75, 80, 77, 74, 69, 72, 72, 71, 69]
        y = [66, 67, 65, 68, 69, 70, 69, 68, 69, 65]

        stats = Significance.repeated_measures_t(x, y)
        stats[:statistic].should be_pseudo_equal(3.1304)
        stats[:p_value].should be_pseudo_equal(0.00605) # One-sided
      end
    end

    # rate = factor(c(2.5, 2.5, ..., 10))
    # price = c(12655, 17877, ..., 26755)
    # a = aov(price ~ rate)
    # s = summary(a)
    # statistic = s[[1]][['F value']][[1]]
    # p.value = pf(15.891605, 3, 8, lower.tail=FALSE)
    describe "#one_way_anova" do
      it "calculates the correct one-way ANOVA F ratio for four samples, one variable according to R" do
        y1 = [12_655, 17_877, 18_766]
        y2 = [19_877, 20_122, 19_888]
        y3 = [21_033, 21_188, 22_099]
        y4 = [25_023, 27_877, 26_755]

        stats = Significance.one_way_anova([y1, y2, y3, y4])
        stats[:statistic].should be_pseudo_equal(15.891605)
        stats[:p_value].should be_pseudo_equal(0.0009869)
      end
    end
  end
end
