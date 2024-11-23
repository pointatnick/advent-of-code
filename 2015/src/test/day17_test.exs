defmodule Day17Test do
  use ExUnit.Case
  doctest Day17.Puzzle

  test "it parses input" do
    assert Day17.Puzzle.parse("37") == 37
  end

  # test "it pours eggnog into no containers" do
  #   assert Day17.Puzzle.pour([20, 15, 10, 5, 5], 1) == 0
  # end

  # test "it pours eggnog into one container" do
  #   assert Day17.Puzzle.pour([20, 15, 10], 10) == 1
  # end

  # test "it pours eggnog into all possible containers" do
  #   assert Day17.Puzzle.pour([20, 15, 10, 5, 5], 25) == 4
  # end

  test "it pours eggnog into one container" do
    assert Day17.Puzzle.pour([20, 15, 10], 10, 0) == %{1 => 1}
  end

  test "it pours eggnog into all possible minimum number of containers" do
    assert Day17.Puzzle.pour([20, 15, 10, 5, 5], 25, 0) == %{3 => 1, 2 => 3}
  end
end
