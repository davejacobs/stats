require 'spec_helper'
include Stats::Assumption

module Stats
  describe "#assume" do
    before do
      self.should_receive(:caller).twice.and_return(["`my_statistical_test'"])
    end

    it "does nothing if its associated block returns true" do
      self.should_not_receive(:puts)
      assume :equal_variance do
        true
      end
    end

    it "displays a warning if its associated block returns false" do
      warning_message = <<-WARNING
[warning] Assumption not met: equal variance in my_statistical_test" 
          Test is likely not valid"
      WARNING

      self.should_receive(:puts).with(warning_message)
      assume :equal_variance do
        false
      end
    end
  end
end
