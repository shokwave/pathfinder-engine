require 'dice'

describe Dice do
  describe 'd6' do
    before do
      @dice = Dice.new(6)
      @rolls = []
      50.times do
        @rolls << @dice.roll
      end
    end
    it "should return a number between 1 and 6 inclusive" do
      @dice.roll.should be_between(1, 6)
    end
    it "should return random results" do
      @rolls.uniq.length.should be > 3
    end
    it "shouldn't gives 0s, 7s, or 25s" do
      @rolls.should_not include 0, 7, 25
    end
  end
end