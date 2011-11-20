module Stats
  module Regression
    class << self

      # Performs linear regression on the supplied data using least
      # squares fit.
      # 
      # Returns the results as an Array of the form: [gradient, intercept]
      def linear_regression(x, y)
        return nil if x.empty? || y.empty? || x.length != y.length
        sum_x = x.reduce(&:+)
        sum_y = y.reduce(&:+)
        sum_xy = x.zip(y).map { |x1,y1| x1 * y1 }.inject(&:+)
        sum_x_squared = x.map { |x1| x1 * x1 }.inject(&:+)

        gradient = (sum_xy - (sum_x * sum_y).to_f / x.length).to_f /  (sum_x_squared - sum_x * sum_x / x.length)
        intercept = (sum_y - gradient * sum_x).to_f / x.length

        return [gradient, intercept]
      end
    end
  end
end


