# tracks hitpoints, keeps a maximum as well as current

require_relative 'statblock'


module HP  
  def hp_initialize(hd, level=1)
    case level
    when 1
      @maxhp = hd + conmod
    else
      @maxhp = hd + (parse "#{level-1}d#{hd}").reduce(:+) + level*conmod
    end
    @hp = @maxhp
    @hd = hd
    @oldmax = nil  
  end
  def max_hp_= newhp
    @maxhp = newhp
  end
  def set_hp_= newhp
    @maxhp = newhp
    @hp = newhp 
  end
  def heal amount
    if ((@hp + amount) > @maxhp)
      @hp = @maxhp
      @hp
    else
      @hp += amount
      @hp
    end
  end
  def hurt amount
    @hp -= amount
    @hp
  end
  def temp_hp amount=0
    if @oldmax
      @maxhp = @oldmax
      @oldmax = nil
      (@hp > @maxhp) ? @hp = @maxhp : @hp
    else
      @oldmax = @maxhp
      @maxhp += amount
      @hp += amount
    end
  end
end

class Test_HP
  
  include HP  
  attr_reader :hp, :maxhp, :oldmax, :hd, :conmod, :level
  
  def initialize(hd, conmod, level=1)
    @conmod = conmod
    hp_initialize hd, level
  end
end
