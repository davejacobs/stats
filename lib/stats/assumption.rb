module Stats
  class Assumption
    # Interface I want:
    # assume "equal variance" do
    #   Basic.variance(x) == Basic.variance(y)
    # end
    #
    # assume "paired values" do
    #   x.length == y.length
    # end
    #
    # intermediate_values :n, :xy_delta, :mean, :variance, :df
  end
end
