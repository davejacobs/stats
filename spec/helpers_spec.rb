require 'spec_helper'

module Stats
  describe Helpers do
    it "#identity" do
      [1, 2, 3].map(&Helpers.identity).should == [1, 2, 3]
    end

    it "#zipmap" do
      Helpers.zipmap([1, 2, 3], &:next).should == { 1 => 2, 2 => 3, 3 => 4 }
    end

    it "#rank_map" do
      Helpers.rank_map([1, 2, 2, 3]).should == { 1 => 1.0, 2 => 2.5, 3 => 4.0 }
    end

    it "#ranks_for" do
      Helpers.ranks_for([1, 2, 3, 4]).should == [1, 2, 3, 4]
      Helpers.ranks_for([1, 1, 2, 3]).should == [1.5, 1.5, 3, 4]
      Helpers.ranks_for([1, 2, 2, 3]).should == [1, 2.5, 2.5, 4]
    end

    it "#average_ranks" do
      Helpers.average_ranks(1, 1).should == [1]
      Helpers.average_ranks(1, 5).should == [3, 3, 3, 3, 3]
      Helpers.average_ranks(2, 2).should == [2.5, 2.5]
    end

    it "#tie_correct" do
      Helpers.tie_correct([1, 2, 3, 4, 5]).should == 1
    end

    it "#partition_ties" do
      Helpers.partition_ties([1, 1, 1, 2, 2, 3, 3, 3, 3, 3]).should == 
        { 1 => 3, 2 => 2, 3 => 5 }
    end
  end
end
