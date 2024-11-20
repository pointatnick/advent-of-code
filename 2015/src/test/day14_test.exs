defmodule Day14Test do
  use ExUnit.Case
  doctest Day14.Puzzle

  test "it parses each line into reindeer stats" do
    assert Day14.Parser.parse(
             "Vixen can fly 8 km/s for 8 seconds, but then must rest for 53 seconds."
           ) == %{
             name: :Vixen,
             rate: 8,
             duration: 8,
             break: 53
           }
  end

  test "it races for x seconds" do
    assert Day14.Puzzle.race(
             %{
               name: :Comet,
               rate: 14,
               duration: 10,
               break: 127
             },
             11
           ) == %{Comet: [14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 0]}
  end
end
