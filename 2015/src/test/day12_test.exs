defmodule Day12Test do
  use ExUnit.Case
  doctest Day12Test

  test "it sums a single number" do
    Day12.Parser.sum(1) == 1
  end

  test "it sums all the numbers in an object" do
    Day12.Parser.sum(%{"a" => 37, "b" => 142}) == 179
  end

  test "it sums all the numbers in an array" do
    Day12.Parser.sum(["yellow", "violet", 21, -30]) == -9
  end
end
