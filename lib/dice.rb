# Instantiate this class with a number to make a die of that number.
# This die can then be rolled once, many times, or many times dropping lowest.
# It has pretty sensible defaults.
# Dice remember their history, for 'what-if' experimenting.
class Dice
  
  attr_reader :history, :sides
  
  def initialize(number)
    @sides = number
    @history = []
  end
    
  def roll
    result = rand(1..@sides)
    @history << result
    result
  end
  
  def roll_many(count=1)
    result = Array.new(count) { rand(1..@sides) }
    @history << result
    result
  end
  
  def roll_many_drop(count=4, drop=1)
    arr = Array.new(count) { rand(1..@sides) }
    arr.sort!.reverse!
    result = [arr.first(arr.size - drop), arr.last(drop)]
    @history << result
    result
  end
  
  
end


# This class is figuratively a 'handful' of dice, for complicated damage.
# Dice can be of lots of different types.
# You can add and remove dice.
# 'roll' will roll all the dice once.
# It will access the history of these dice, for 'what-if' experimenting.
class Handful
  attr_accessor :die, :name
  def initialize(title, *sides)
    @name = title
    @sides = sides
    @die = []
    @sides.each {|side| @die << Dice.new(side)}
  end
  def to_s
    the_sides = []
    @sides.each{|side| the_sides << "d"+"#{side}"+"\t" }
    the_histories = []
    @die.each{|die_obj| the_histories << die_obj.history }
    info = the_sides.zip the_histories
    "These are #{title} dice.
    #{info}"
  end
  def roll
    @die.each do |die|
      die.roll
    end
  end
  # Very technical: rolls one die, nil in all other die to preserve matching history.  
  def roll_one diceindex
    result = @die[diceindex].roll
    others = @die.partition{ |obj| obj == @die[diceindex] }.last
    others.each { |obj| obj.history << nil }
    result
  end
end