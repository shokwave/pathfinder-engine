require 'dice'

describe Dice do
  describe 'd6' do
    let (:dice) { Dice.new(6) }
    
    it "should return a number between 1 and 6 inclusive" do
      dice.roll.should be_between(1, 6)
    end
    
    describe 'multiple rolls' do
      let (:rolls) do
        rolls = []
        50.times do
          rolls << dice.roll
        end
        rolls
      end

      it "should return random results" do
        rolls.uniq.length.should be > 3
      end

      it "shouldn't gives 0s, 7s, or 25s" do
        rolls.should_not include 0, 7, 25
      end
      
    end
  end
end