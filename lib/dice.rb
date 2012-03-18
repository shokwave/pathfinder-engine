class Dice
  def initialize(number)
    @number = number
  end
    
  def roll
    rand(1..@number)
  end
end
