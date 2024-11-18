defmodule Day10Test do
  defmodule PuzzleTest do
    use ExUnit.Case
    doctest Day10.Puzzle

    test "it plays look-and-see and returns the final length" do
      assert Day10.Puzzle.solve(:U, 3) == 4
    end

    test "it decays the element the appropriate number of times" do
      assert Day10.Puzzle.decay(:U, 3) == "3113"
    end
  end
end
