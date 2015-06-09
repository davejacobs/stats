require 'rspec'
require 'stats'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    # c.syntax = :expect             # disables `should`
    # c.syntax = [:should, :expect]  # default, enables both `should` and `expect`
    c.syntax = :should             # disables `expect`
  end
end

RSpec::Matchers.define :be_pseudo_equal do |num2|
  match do |num1|
    epsilon = 0.0001
    (num1 - num2).abs.should < epsilon
  end
end
