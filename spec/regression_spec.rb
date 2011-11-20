require 'spec_helper'

module Stats
  describe Regression do
    it "performs linear regression using least squares fit" do
      x = []
      y = [1, 2, 3, 4, 5]
      Regression.linear_regression(x, y).should == nil

      x = [1, 2, 3, 4, 5]
      y = []
      Regression.linear_regression(x, y).should == nil

      x = [1, 2, 3, 4, 5]
      y = [1, 2, 3, 4, 5, 6]
      Regression.linear_regression(x, y).should == nil

      x = [2, 4, 6, 8]
      y = [2, 5, 5, 8]
      Regression.linear_regression(x, y).should == [0.9, 0.5]

      x = [1, 2, 3, 4, 5]
      y = [2, 4, 6, 8, 10]
      Regression.linear_regression(x, y).should == [2, 0]

      x = [0, 1, 2, 3, 4]
      y = [3, 6, 7, 8, 11]
      Regression.linear_regression(x, y).should == [1.8, 3.4]

      x = [1, 2, 3, 4, 5]
      y = [2, 4, 6, 8, 10]
      Regression.linear_regression(x, y).should == [2, 0]
    end
  end
end

