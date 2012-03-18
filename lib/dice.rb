# mountains are merely mountains
# provides dice-rolling, a parser for multiple dice rolling

def parse xdydz
  nums = xdydz.split 'd'
  case nums.length
    when 2
      arr = roll nums[1].to_i, nums[0].to_i
    when 3
      temp = roll nums[1].to_i, nums[0].to_i
      arr = temp.sort[nums[2].to_i..-1]
    else
      p "1 or 2 'd's in roll requests please" # excellent error handling
    end
  return arr
end

def roll (die, num = 1)
  arr = []
  num.times{ arr << rand(die)+1 }
  return arr
end