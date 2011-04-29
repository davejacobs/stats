require 'spec_helper'

module Stats
  describe Math do
    it "performs basic sums" do
      numbers = [1, 2, 3]
      Math.sum(numbers).should == 6
    end

    it "integrates linear functions" do
      identity = lambda {|x| x }
      Math.integrate(0..1, &identity).should == 0.5
    end

    it "integrates quadratic functions" do
      quadratic = lambda {|x| x ** 2 }
      Math.integrate(0..1, &quadratic).should be_pseudo_equal(1.0/3)
    end

    it "integrates trigonometric functions" do
      sin = lambda {|x| ::Math.sin(x) }
      Math.integrate(0..1, &sin).should == 1 - ::Math.cos(1)
    end

    it "integrates exponential function" do
      e = lambda {|x| ::Math.exp(x) }
      Math.integrate(0..1, &e).should be_pseudo_equal(::Math.exp(1) - 1)
    end
  end
end
