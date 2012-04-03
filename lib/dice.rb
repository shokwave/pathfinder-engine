# Instantiate this class with a number to make a die of that number.
# This die can then be rolled once, many times, or many times dropping lowest.
# It has pretty sensible defaults.
# Dice remember their history, for 'what-if' experimenting.
class Dice
  def initialize(number)
    @number = number
  end
    
  def roll
    rand(1..@number)
  end
  
  def roll_many(count=1)
    Array.new(count) { roll }
  end
  
  def roll_many_drop(count=4, drop=1)
    arr = roll_many(count).sort.reverse
    [arr.first(arr.size - drop), arr.last(drop)]
  end
end


# This class is figuratively a 'handful' of dice, for complicated damage.
# Dice can be of lots of different types.
# You can add and remove dice.
# 'roll' will roll all the dice once.
# It will access the history of these dice, for 'what-if' experimenting.
class Handful
end