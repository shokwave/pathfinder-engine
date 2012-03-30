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

