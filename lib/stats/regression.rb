module Stats
  module Regression
    class << self

      # Performs linear regression on the supplied data using least
      # squares fit.
      # 
      # Returns the results as Hash with keys 'gradient' and 'intercept' which
      # map to the gradient and intercept respectively.
      def linear_regression(x, y)
        return nil if x.length < 2 || y.length < 2 || x.length != y.length
        sum_x = x.reduce(&:+)
        sum_y = y.reduce(&:+)
        sum_xy = x.zip(y).map { |x1, y1| x1 * y1 }.reduce(&:+)
        sum_x_squared = x.map { |x1| x1 * x1 }.reduce(&:+)

        gradient = (sum_xy - (sum_x * sum_y).to_f / x.length).to_f /  (sum_x_squared - sum_x * sum_x / x.length)
        intercept = (sum_y - gradient * sum_x).to_f / x.length

        ['gradient' => gradient, 'intercept' => intercept]
      end
    end
  end
end


