# merely mountains
# characters as objects getting all the module methods as class instance methods

require_relative 'statistics'
require_relative 'hp'
require_relative 'items'

class Character
  
  include Statblock
  include HP
  include Inventory
  attr_accessor :strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma, :items, :inventory, :hitbonus, :fordamage
  attr_accessor :fortitude, :will, :reflex
  attr_reader :hp, :level
  
  # pull together a bunch of module initialize methods
  def initialize(charclass, level, stats, holding)
    @level = level
    @charclass = charclass
    statblock_initialize stats
    hp_initialize Tables::Class[%s(charclass)][:hitdie], level
    inventory_intialize holding    
    @hitbonus = [strmod, items.values_at(:hit)].flatten  #
    @fordamage = [strmod, ]  #
  end
  
  
  
  # 'roll to hit'
  def tohit
    hitbonus.inject(:+) + roll 20
  end
  
  # 'roll for domage'
  def fordamage
    damagebonus.inject(:+) + roll weapon
  end
end