require 'items'

describe Item do
  describe 'ring of strength' do
    let(:ros) { Item.new 'ring of strength', ['strength', 4, :wisdom, 2] }
    
    subject { :ros }
    
    it should { respond_to :name }
    it should { respond_to :attributes }
    
    its(:name) { should be_a String }
    its(:attributes) { should be_a Hash }
    
  end
  
end

