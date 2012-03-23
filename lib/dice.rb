class Dice
  def initialize(number)
    @sides = number
  end
    
  def roll
    rand(1..@sides)
  end
  
  def roll_many(count=1)
    Array.new(count) { roll }
  end
  
  def roll_many_drop(count=1, drop=1)
    rolls = roll_many(count).sort.reverse
    [rolls.first(rolls.size-drop), rolls.last(rolls.size - (rolls.size-drop))]
  end
end
