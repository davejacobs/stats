require 'spec_helper'

module Stats
  describe Significance do
    before do
      @r = RinRuby.new(:echo => false)
    end

    describe "#chi_square" do
      it "calculates the correct Chi Square stats for df = 1 according to R" do
        stats = Significance.chi_square([85, 15], [75, 25], 1)
        stats[:statistic].should be_pseudo_equal(5.33333333)
        stats[:p_value].should be_pseudo_equal(0.01200306)
      end
    end

    # In R:
    # x = c(62, 92, ..., 95)
    # mean = 70
    # t.test(x, mu=mean, alternative='greater')
    describe "#one_sample_t" do
      it "calculates the correct one-sided, one-sample T stats according to R" do
        x = [62, 92, 75, 68, 83, 95]
        population_mean = 70

        stats = Significance.one_sample_t(x, population_mean)
        stats[:statistic].should be_pseudo_equal(1.7053)
        stats[:p_value].should be_pseudo_equal(0.07443) # One-sided
      end
    end

    # In R:
    # x = c(89.2, 78.2, ..., 89.3)
    # y = c(79.3, 78.3, ..., 79.9)
    # t.test(x, y, paired=FALSE, alternative='greater')
    describe "#two_sample_t" do
      it "calculates the correct one-sided, two-sample T stats according to R" do
        x = [89.2, 78.2, 89.3, 88.3, 87.3, 90.1, 95.2, 94.3, 78.3, 89.3]
        y = [79.3, 78.3, 85.3, 79.3, 88.9, 91.2, 87.2, 89.2, 93.3, 79.9]

        @r.x = x
        @r.y = y

        @r.eval <<-RSCRIPT
          t <- t.test(x, y, paired=FALSE, alternative='greater')
          statistic <- t$statistic
          p_value <- t$p.value
        RSCRIPT

        stats = Significance.two_sample_t(x, y)
        stats[:statistic].should be_pseudo_equal(@r.statistic)
        stats[:p_value].should be_pseudo_equal(@r.p_value) # One-sided
      end
    end

    # In R:
    # x = c(65, 75, ..., 69)
    # y = c(66, 67, ..., 65)
    # t.test(x, y, paired=TRUE, alternative="greater")
    describe "#repeated_measures_t" do
      it "calculates the correct one-sided, repeated-measure T stats according to R" do
        x = [65, 75, 80, 77, 74, 69, 72, 72, 71, 69]
        y = [66, 67, 65, 68, 69, 70, 69, 68, 69, 65]

        stats = Significance.repeated_measures_t(x, y)
        @r.x = x
        @r.y = y

        @r.eval <<-RSCRIPT
          t <- t.test(x, y, paired=TRUE, alternative='greater')
          statistic <- t$statistic
          p_value <- t$p.value
        RSCRIPT

        stats[:statistic].should be_pseudo_equal(@r.statistic)
        stats[:p_value].should be_pseudo_equal(@r.p_value) # One-sided
      end
    end

    describe "#unequal_variance_t"

    # This function currently isn't working according to R but is working
    # according to SciPy. Because the R definition handles more cases and
    # constraints, and it has heuristics for more accuracy on small batches
    # of data, I'll keep this simple for now and match the Python version.
    #
    # In Python:
    # stats.ranksums(x, y) = (-2.625525, 0.008651)
    #
    # Notes for (in the future) getting this to match R's values:
    # According to R, the W statistic should be 7, which is correct.
    # However, the p value should be 0.003497 or double that. I thought
    # that perhaps the survival function wasn't correct, but I just checked the
    # call in R (integrate(dnorm, 2.573014654401468, Inf)$value) and
    # get 0.00504, which is what I'm getting in Ruby. So it seems like the problem is somewhere between the statistic calculation
    # and the z calculation.
    #
    # In R:
    # x = c(1, 1.2, ..., 6)
    # y = c(4, 5.1, ..., 7.3)
    # wilcox.test(x, y, alternative='less')
    describe "#wilcoxon_rank_sum" do
      it "calculates the correct Wilcoxon rank sum stats according to Python" do
        x = [1, 1.2, 1.4, 2, 3, 4.5, 4.6, 6]
        y = [4, 5.1, 5.2, 5.3, 5.8, 7.1, 7.2, 7.3]

        stats = Significance.wilcoxon_rank_sum(x, y)
        stats[:statistic].should == 57
        stats[:p_value].should be_pseudo_equal(0.008651)
      end

      # TODO: Make this work
      it "calculates the correct Wilcoxon rank sum stats according to R"
    end

    describe "#wilcoxon_signed_rank"

    # *Statistics in a Nutshell*, pp. 215ff
    describe "#kruskal_wallis_h" do
      it "calculates the correct Kruskall-Wallis H statistic and p value according to R" do
        x = [4, 5, 6, 6, 7, 8, 9, 9, 9]
        y = [2, 3, 3, 4, 4, 5, 10, 10, 11]
        z = [10, 9, 10, 6, 6, 7, 8, 7, 6]

        stats = Significance.kruskal_wallis_h(x, y, z)
        stats[:statistic].should be_pseudo_equal(2.2654321)
        stats[:p_value].should be_pseudo_equal(0.3164)
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
