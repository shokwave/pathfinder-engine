require 'dice'

describe Dice do
  describe 'd6' do
    let (:dice) { Dice.new(6) }
    
    subject { dice }  
    
    it { should respond_to(:roll) }
    it { should respond_to(:roll_many) }
    it { should respond_to(:roll_many_drop) }
    it { should respond_to(:history) }
    it { should respond_to(:sides) }
    
    its(:sides) { should be 6 }
    
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
          subject.first.last.should be >= subject.last.first
        end
      end
    end
  end
  
  describe 'history of a die' do
    let (:dice) { Dice.new(6) }
    
    before(:each) do
      dice.roll
      dice.roll_many 30
      dice.roll_many_drop
    end
    
    it 'should have three things in its history' do
      dice.history.size.should be 3
    end
    
    it 'should have an integer as its first result' do
      dice.history.first.should be_a Integer
    end
    
    it 'should have a number between 1 and 6 as its first result' do
      dice.history.first.should be_between 1, 6
    end
    
    it 'should have an array as its second result' do
      dice.history[1].should be_a Array
    end
    
    it 'should have 30 rolls in the second history result' do
      dice.history[1].size.should be 30
    end
    
    it 'should have an array as its last result' do
      dice.history.last.should be_a Array
    end
    
    it 'should have 2 arrays of rolls in the last history result' do
      dice.history.last.size.should be 2
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
