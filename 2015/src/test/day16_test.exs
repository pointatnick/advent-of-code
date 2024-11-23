defmodule Day16Test do
  use ExUnit.Case
  doctest Day16.Puzzle

  test "it parses input" do
    assert Day16.Puzzle.parse("Sue 1: goldfish: 6, trees: 9, akitas: 0") ==
             %{sue_num: 1, goldfish: 6, trees: 9, akitas: 0}
  end

  test "it compares maps" do
    sample = %{
      children: 3,
      cats: 7,
      samoyeds: 2,
      pomeranians: 3,
      akitas: 0,
      vizslas: 0,
      goldfish: 5,
      trees: 3,
      cars: 2,
      perfumes: 1
    }

    refute Day16.Puzzle.has_match?(sample, %{goldfish: 6, trees: 9, akitas: 0})
    assert Day16.Puzzle.has_match?(sample, %{samoyeds: 2, cars: 2, perfumes: 1})
  end
end
