defmodule Day11Test do
  use ExUnit.Case
  doctest Day11.Puzzle

  test "it increments strings" do
    assert Day11.Password.increment(~c"cqjxjnds") == ~c"cqjxjndt"
  end

  test "it skips i, o, and l when incrementing" do
    assert Day11.Password.increment(~c"h") == ~c"j"
    assert Day11.Password.increment(~c"n") == ~c"p"
    assert Day11.Password.increment(~c"k") == ~c"m"
  end

  test "it increments from z to a" do
    assert Day11.Password.increment(~c"z") == ~c"a"
  end

  test "it increments character to the left on overlap" do
    assert Day11.Password.increment(~c"czzzzzzz") == ~c"daaaaaaa"
  end

  test "it fails strings without a straight" do
    refute Day11.Password.valid?("abbceffg")
  end

  test "it fails strings with i, o, or l" do
    refute Day11.Password.valid?("hljklmmn")
    refute Day11.Password.valid?("hijkimmn")
    refute Day11.Password.valid?("hojkommn")
  end

  test "it fails strings with only one pair" do
    refute Day11.Password.valid?("abbcegjk")
  end
end
