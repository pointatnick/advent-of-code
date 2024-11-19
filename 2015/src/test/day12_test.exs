defmodule Day12Test do
  use ExUnit.Case
  doctest Day12.Puzzle

  test "it sums a single number" do
    assert Day12.Parser.sum(1) == 1
  end

  test "it sums 0 for string, boolean, or null" do
    assert Day12.Parser.sum("hi") == 0
    assert Day12.Parser.sum(true) == 0
    assert Day12.Parser.sum(nil) == 0
  end

  test "it sums all the numbers in list" do
    assert Day12.Parser.sum(["yellow", "violet", 21, -30]) == -9
    assert Day12.Parser.sum(["yellow", %{"a" => [5]}, 21, -30]) == -4
  end

  test "it sums all the numbers in an object" do
    assert Day12.Parser.sum(%{"a" => 37, "b" => 142}) == 179
    assert Day12.Parser.sum(%{"a" => [1, 37], "b" => %{"c" => ["hello", 142]}}) == 180
  end

  test "it ignores sums for objects with the property `red`" do
    assert Day12.Parser.sum([1, %{"a" => 37, "b" => "red"}, 3]) == 4
  end
end
