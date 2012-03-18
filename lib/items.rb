# has items, carries their bonuses information in some clever way
# here's the clever way: hash of item names => [bonus, to-what, bonus, to-what]
# then when something accesses data, can turn name into variable with bonus and to-what
# into hash key. so 'belt of giant strength' => [2, strength] becomes 
# strength: belt_of_giant_strength=2
# generate hash dynamically from scraped text, less time to make

module Inventory
  def inventory_initialize holding
    @items = {}
    @inventory = holding
    holding.each do |item|
      @items[Wondrous::[item][1]] = Wondrous::[item][0]
    end
  end
  def acquire item
    @inventory << item
    @items.merge!({Wondrous::[item][1] => Wondrous::[item][0]}) {|key, oldv, newv| [oldv, newv].flatten}
end

module Items
  Weapons = {}
  Armor = {}
  Wondrous = {
    'belt of giant strength' => [4, :strength]
  }
end