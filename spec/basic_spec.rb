require 'spec_helper'

# A statistics library needs to be well-tested. As it stands,
# this spec is a basic validation that the library works as expected.
# Further testing will be carried out against Wilkinson's 
# "Statistics Quiz" [0] and "Assessing the reliability of 
# statistical software", parts 1 [1] and 2 [2].
#
# [0]: http://tspintl-test.com/products/tsp/benchmarks/wilk.rtf
# [1]: http://www.questia.com/googleScholar.qst?docId=5001390400
# [2]: http://www.questia.com/googleScholar.qst?docId=5001888610

module Stats
  describe Basic do
    let(:empty)       { [] }
    let(:normal_odd)  { [1, 2, 3, 4, 5] }
    let(:normal_even) { [1, 2, 3, 4, 5, 6] }
    let(:duplicates)  { [1, 1, 2, 3, 3, 3, 4, 5] }

    context "analyzing type agnostic data" do
      it "#arithmetic_mean" do
        Basic.arithmetic_mean(empty).should == nil
        Basic.arithmetic_mean(normal_odd).should == 3
        Basic.arithmetic_mean(duplicates).should == 22/8.0
      end

      it "#geometric_mean" do
        Basic.geometric_mean(empty).should == nil
        Basic.geometric_mean(normal_odd).should be_pseudo_equal(2.60517)
        Basic.geometric_mean(duplicates).should be_pseudo_equal(2.39429)
      end

      it "#median" do
        Basic.median(empty).should == nil
        Basic.median(normal_odd).should == 3
        Basic.median(normal_even).should == 3.5
        Basic.median(duplicates).should == 3
      end

      it "#mode" do
        Basic.mode(empty).should == nil
        Basic.mode(normal_odd).should == nil
        Basic.mode(duplicates).should == 3
        
        # Median-specific special cases
        Basic.mode([1, 2, 2, 2, 3, 3, 4, 5, 5, 5, 5, 5]).should == 5
        Basic.mode([1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5]).should == [2, 3]
      end
    end

    context "analyzing populations" do
      it "#variance" do
        Basic.variance(empty).should == nil
        Basic.variance(duplicates).should be_pseudo_equal(1.6875)
      end

      it "#std" do
        Basic.std(empty).should == nil
        Basic.std(duplicates).should be_pseudo_equal(1.29904)
      end
    end

    context "analyzing samples" do
      it "#variance" do
        Basic.variance(empty, :sample).should == nil
        Basic.variance(duplicates, :sample).should be_pseudo_equal(1.92857)
      end

      it "#std" do
        Basic.std(empty, :sample).should == nil
        Basic.std(duplicates, :sample).should be_pseudo_equal(1.38873)
      end
    end
  end
end
