# mountains are merely mountains
# statblock holds stats, gives mods
require_relative 'dice'

def ranblock
  arr = []
  6.times{arr << (parse '4d6d1').reduce(:+)}
  arr
end

module Statblock
  def statblock_initialize(stats)
    @strength, @dexterity, @constitution, @intelligence, @wisdom, @charisma = *stats
  end

  def strmod
    (@strength + @items.values_at(:strength).reduce - 10) / 2
  end
  def dexmod
    (@dexterity + @items.values_at(:dexterity).reduce - 10) / 2
  end
  def conmod
    (@constitution + @items.values_at(:constitution).reduce - 10) / 2
  end
  def intmod
    (@intelligence + @items.values_at(:intelligence).reduce - 10) / 2
  end
  def wismod
    (@wisdom + @items.values_at(:wisdom).reduce - 10) / 2
  end
  def chamod
    (@charisma + @items.values_at(:charisma).reduce - 10) / 2
  end
end

module Saves
  def saves_initialize
    @fortitude = Tables::Class[%s[@charclass]][:fort][@level]
    @reflex = Tables::Class[%s[@charclass]][:refl][@level]
    @will = Tables::Class[%s[@charclass]][:will][@level]
    

# for testing?
class Statistics  
  include Statblock
  attr_accessor :str, :dex, :con, :int, :wis, :cha
  def initialize(stats)
    stat_initialize stats
  end
end
