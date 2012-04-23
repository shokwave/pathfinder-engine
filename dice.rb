COLOURS = %w[gold silver red blue green cyan turquoise purple orange yellow clear black amber brown magenta violet green grey white opal pink cream]
MODS = %w[dark light bright faded metallic pearlescent pastel mottled sparkling deep]
ALTS = %W[flecks lines swirls spirals blobs splashes]

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
  
  def roll
    result = 1 + rand(@sides)
    @past << result
    result
  end
  
  def to_s
    "A d#{@sides}, #{@colour}."
  end  
end



class Dicepool
end

class Dicebox
end
