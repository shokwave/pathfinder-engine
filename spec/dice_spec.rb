require 'dice'

describe Dice do
  describe 'd6' do
    let (:dice) { Dice.new(6) }
    
    subject { dice }  
    
    it { should respond_to(:roll) }
    it { should respond_to(:roll_many) }
    
    describe "rolling" do
      subject { dice.roll }
      
      it { should be_between(1, 6) }
      it { should be_a(Integer) }
      
    end
    
    describe 'multiple rolls' do
      let(:rolls) { dice.roll_many(30) }
      
      subject { rolls }
      
      it "should not return all the same value" do
        subject.uniq.size.should be > 4
      end
      
<<<<<<< Updated upstream
      its(:size) { should be(30) }
      it { should_not include(0, 7, 25) }
      
=======
      its(:size) { should be 30 }
      it { should_not include 0, 7, 25 }
      
    end
    
    describe 'rolling with drops' do
      describe 'dropping lowest' do
        let(:droponce) { dice.roll_many_drop 4, 1}
        
        its(:size) { should be 2 }
      end
>>>>>>> Stashed changes
    end
  end
end