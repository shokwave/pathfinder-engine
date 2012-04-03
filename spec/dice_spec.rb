require 'dice'

describe Dice do
  describe 'd6' do
    let (:dice) { Dice.new(6) }
    
    subject { dice }  
    
    it { should respond_to(:roll) }
    it { should respond_to(:roll_many) }
    it { should respond_to(:roll_many_drop) }
    it { should respond_to(:history) }
    
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

      its(:size) { should be 30 }
      it { should_not include 0, 7, 25 }
      
    end
    
    describe 'rolling with drops' do
      describe 'dropping lowest' do
        let(:droponce) { dice.roll_many_drop 4, 1 }
        subject { droponce }
        
        it "should be two arrays" do
          subject.size.should be 2
        end
        it "should have its last number be its smallest" do
          subject.first.last.should be > subject.last.first
        end
      end
    end
  end
end

describe Handful do
  let (:damage_dice) { Handful.new "damage", [6, 6, 6, 6] }
  subject { damage_dice }
  
  it { should respond_to(:roll) }
  # it { should respond_to(:roll_one) }
  # it { should respond_to(:add) }
  # it { should respond_to(:history) }
  
  describe "rolling" do
    subject { damage_dice.roll }
    
    its(:size) { should be 4 }
    it { should be_a(Array) }
    it "should not have any elements outside of one to six" do
      subject.each {|val| val.should be_between(1, 6) }
    end
  end
end
