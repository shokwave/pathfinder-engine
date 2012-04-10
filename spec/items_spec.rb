require 'items'

describe Item do
  describe 'ring of strength' do
    let(:ros) { Item.new 'ring of strength', ['strength', 4, :wisdom, 2] }
    
    subject { ros }
    
    it { should respond_to :name }
    it { should respond_to :attributes }
    
    its(:name) { should be_a String }
    its(:attributes) { should be_a Hash }
    it 'should have :strength as its first key' do
      subject.attributes.first.first.should be :strength
    end
    it 'should have 4 as its first value' do
      subject.attributes.first.last.should be 4
    end
    
    
  end
  
end

