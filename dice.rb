# Inspired by the Dice Rolling Reference from Roll20:
# http://help.roll20.net/dice-rolling-reference/

# Add some flavour.
COLOURS = %w[gold silver red blue green cyan turquoise purple orange yellow clear black amber brown magenta violet green grey white opal pink cream]
MODS = %w[dark light bright faded metallic pearlescent pastel mottled sparkling deep]
ALTS = %W[flecks lines swirls spirals blobs splashes]

# Each die remembers its history. It also gets some @colour flavour from COLOURS, MODS, ALTS.
class Die
  
  attr_accessor :past, :sides, :colour
  
  def initialize sides
    @past = []
    @sides = sides
    col1, col2 = COLOURS.sample(2)
    mod = MODS.sample
    alt = ALTS.sample
    if rand < 0.75
      @colour = "#{mod} #{col1} with #{alt} of #{col2}"
    else
      @colour = "#{col1} with #{alt} of #{mod} #{col2}"
    end
  end
  
  # Stores the result in @past, returns the result.
  def roll
    result = 1 + rand(@sides)
    @past << result
    result
  end
  
  # Pretty printing.
  def to_s
    "A d#{@sides}, #{@colour}."
  end

end


# Adds 'exploding' quality: rolling the highest result scores you a re-roll. 
class ExplodingDie < Die
  
  # Keeps rolling while result equals @sides.
  def roll
    result = [] << 1 + rand(@sides)
    while result.last == @sides
      result << 1 + rand(@sides)
    end
    @past << result
    result
  end
  
  # Pretty printing.
  def to_s
    "An exploding d#{@sides}, #{@colour}."
  end
  
end



# Exploding die for the highest N results.
class MultipleExplodingDie < ExplodingDie
  
  attr_accessor :explode
  
  def initialize sides, explode
    @explode = explode
    @past = []
    @sides = sides
    col1, col2 = COLOURS.sample(2)
    mod = MODS.sample
    alt = ALTS.sample
    if rand < 0.75
      @colour = "#{mod} #{col1} with #{alt} of #{col2}"
    else
      @colour = "#{col1} with #{alt} of #{mod} #{col2}"
    end
  end
  
  # Keeps rolling while the result is greater than sides minus N.
  def roll
    result = [] << 1 + rand(@sides)
    while result.last > @sides-@explode
      result << 1 + rand(@sides)
    end
    @past << result
    result
  end
  
  # Pretty printing.
  def to_s
    "A d#{@sides}, #{@colour}. Explodes on #{explode} highest results."
  end
  
end



# A target number die cares if it rolls higher than a certain number.
# Get the actual rolls with .past_rolls.
class TargetDie < Die
  
  attr_accessor :past_raw
  
  def initialize sides, target
    @target = target
    @past_rolls = []
    @sides = sides
    col1, col2 = COLOURS.sample(2)
    mod = MODS.sample
    alt = ALTS.sample
    if rand < 0.75
      @colour = "#{mod} #{col1} with #{alt} of #{col2}"
    else
      @colour = "#{col1} with #{alt} of #{mod} #{col2}"
    end
  end

  # Stores the result in @past, returns true if success, false elsewise.
  def roll
    result = 1 + rand(@sides)
    @past_rolls << result
    result >= target
  end
  
  # Get the past of this die, translated into success/failure.
  def past
    result = @past_rolls.map do |value|
      value >= target
    end
    result
  end
  
  # Pretty printing.
  def to_s
    "A d#{@sides} target #{@target} die, #{@colour}."
  end
  
end


# The FATE die rolls either -1, 0, or +1.
class FateDie < Die
  def initialize *sides
    # Throw away sides.
    @past = []
    @sides = 3
    col1, col2 = COLOURS.sample(2)
    mod = MODS.sample
    alt = ALTS.sample
    if rand < 0.75
      @colour = "#{mod} #{col1} with #{alt} of #{col2}"
    else
      @colour = "#{col1} with #{alt} of #{mod} #{col2}"
    end
  end
  
  def roll
    result = rand(@sides) - 1
    @past << result
    result
  end

  # Pretty printing.
  def to_s
    "A FATE die, #{@colour}."
  end

end




# Holds a collection of dice and gives it a name.
class DicePool
  
  attr_accessor :pool, :past, :name
  
  def initialize name, *sides
    @name = name
    @past = []
    @pool = []
    sides.each do |num|
      @pool << Dice.new num
    end
  end
  
  # This is the canonical style: roll each die and refer to its history.
  # DicePool `roll` packages up the results for you, but it's equivalent to
  # `store = []; @pool.each do |die| store << die.past end; store.transpose`.
  def roll
    result = []
    @pool.each do |die| 
      die.roll
      result << die.past.last
    end
    @past << result
    result
  end
  
  # Pretty printing.
  def to_s
    sides = @sides.map{|v| "d#{v}" }
    "#{@name}: #{sides}."
  end
    
end


# A DicePool extension that takes `drop` as an extra argument,
# and drops that many of the lowest results.
class DroppingDicePool < DicePool
  
  attr_accessor :drop
  
  def initialize name, *sides, dropping
    @drop = dropping
    @name = name
    @past = []
    @pool = []
    sides.each do |num|
      @pool << Dice.new num
    end
  end
  
  # Returns an array of the 'kept' values and 'dropped' values respectively.
  def roll
    result = []
    @pool.each do |die| 
      die.roll
      result << die.past.last
    end
    drop_partition = [result.sort.reverse.first(result.length-@drop), result.sort.reverse.last(@drop)]
    @past << drop_partition
    drop_partition.first
  end
  
  # Pretty printing.
  def to_s
    sides = @sides.map{|v| "d#{v}" }
    "#{@name} dropping lowest #{@drop}: #{sides}."
  end
  
end


# A DicePool extension that takes `keep` as an extra argument,
# and keeps that many of the highest results.
class KeepingDicePool < DicePool
  
  attr_accessor :keep
  
  def initialize name, *sides, keeping
    @keep = keeping
    @name = name
    @past = []
    @pool = []
    sides.each do |num|
      @pool << Dice.new num
    end
  end
  
  # Returns an array of the 'kept' values and 'dropped' values respectively.
  def roll
    result = []
    @pool.each do |die| 
      die.roll
      result << die.past.last
    end
    keep_partition = [result.sort.reverse.first(@keep), result.sort.reverse.last(result.size-@keep)]
    @past << keep_partition
    keep_partition.first
  end

  # Pretty printing.
  def to_s
    sides = @sides.map{|v| "d#{v}" }
    "#{@name} keeping highest #{@keep}: #{sides}."
  end
  
end


# The FateDicePool is your standard four FATE dice.
# Has a custom past method for translating to fudge factor.
# Use @past_rolls to access raw rolls.
class FateDicePool < DicePool
  
  attr_accessor :past_rolls
  
  def initialize name, *sides
    @name = name
    @past_rolls = []
    @pool = [FateDie.new, FateDie.new, FateDie.new, FateDie.new]
  end
  
  def roll
    result = []
    @pool.each do |die| 
      die.roll
      result << die.past.last
    end
    @past_rolls << result
    result.inject(:+)
  end
  
  def past
    result = @past_rolls.each do |four|
      four.inject(:+)
    end
    result
  end
  
  # Pretty printing.
  def to_s
    "FATE dice: #{@name}."
  end
  
end




# DiceBox holds all of a player's dice and dicepools.
class DiceBox
end
