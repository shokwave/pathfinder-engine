require 'test/unit'
require_relative '../lib/hp'

class TestHP < Test::Unit::TestCase
  def setup
    @test_hp = Test_HP.new 12, 4, 8
    @test_max_hp = @test_hp.maxhp
  end
  def teardown
    @test_hp = nil
    @test_max_hp = nil
  end
  def test_can_be_hurt
    @test_hp.hurt 10
    assert_equal(@test_max_hp - 10, @test_hp.hp)    
  end
  def test_can_be_healed
    @test_hp.hurt 15
    @test_hp.heal 10
    assert_equal(@test_max_hp - 5, @test_hp.hp)
  end
  def test_no_overheal
    @test_hp.hurt 5
    @test_hp.heal 20
    assert_equal(@test_max_hp, @test_hp.hp)
  end
  def test_temporary_hp
    @test_hp.temp_hp 15
    assert_equal(@test_max_hp + 15, @test_hp.hp)
  end
  def test_temporary_hp_not_exhausted_works
    @test_hp.temp_hp 15
    @test_hp.hurt 10
    @test_hp.temp_hp
    assert_equal(@test_max_hp, @test_hp.hp)
  end
  def test_temporary_hp_exhausted_works
    @test_hp.temp_hp 15
    @test_hp.hurt 20
    @test_hp.temp_hp
    assert_equal(@test_max_hp - 5, @test_hp.hp)    
  end
  
  
  
# end of class  
end