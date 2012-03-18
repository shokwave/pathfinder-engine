# testing

require 'test/unit'
require 'lib/tables'

class TestTables < Test::Unit::TestCase
  TABLES = [Tables::Save[:good], Tables::Save[:medium],
  Tables::Save[:poor], Tables::Bab[:good], Tables::Bab[:medium],
  Tables::Bab[:poor], Tables::Feats[:base], Tables::Feats[:fighter], 
  Tables::Feats[:human]]
  def test_correct_data
    assert_equal(4, Tables::Save[:good][4])
    assert_equal(10, Tables::Bab[:poor][20])
    assert_equal(1, Tables::Feats[:base][3])
    assert_equal(10, Tables::HitDie[:fighter])
  end
  def test_consistent_zero_is_nil
    TABLES.each_cons(2) do |(first, second)| 
      assert_equal(first[0], second[0], "problem in #{first} or in #{second}")
    end
  end
  def test_undefined_for_higher_than_twenty
    TABLES.each_cons(2) do |(first, second)|
      assert_equal(first[21], second[21], "problem in #{first} or in #{second}")
    end
  end
end