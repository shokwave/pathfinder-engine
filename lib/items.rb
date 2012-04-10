
class Item
  attr_accessor :name, :attributes
  
  def initialize name, attributes
    @name = name
    @attributes = {}
    attributes.each_slice(2){ |stat, bonus| @attributes[stat.to_sym] = bonus }
  end
  
end
