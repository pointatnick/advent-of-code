defmodule Day15Test do
  use ExUnit.Case
  doctest Day15.Puzzle

  test "it scores recipes" do
    assert Day15.Puzzle.score_recipe([-1, 2], [-2, 3], [6, -2], [3, -1], [44, 56]) ==
             62_842_880
  end

  test "it sums the traits of a single recipe" do
    assert Day15.Puzzle.sum_trait([-1, 2], [44, 56]) == 68
  end
end
