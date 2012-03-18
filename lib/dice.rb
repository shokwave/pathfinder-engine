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
end
