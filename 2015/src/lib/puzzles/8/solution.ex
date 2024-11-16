defmodule Puzzle do
  def solve do
    "lib/puzzles/8/input.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Parser.parse/1)
    |> Enum.map(fn [x, y] -> x - y end)
    |> Enum.sum()
  end
end
