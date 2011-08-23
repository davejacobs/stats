require 'rspec'
require 'stats'

RSpec::Matchers.define :be_pseudo_equal do |num2|
  match do |num1|
    epsilon = 0.0001
    (num1 - num2).abs.should < epsilon
  end
end
