defmodule Day8.Puzzle do
  def solve do
    "lib/puzzles/8/input.txt"
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Day8.Parser.parse/1)
    |> Enum.map(fn [x, y] -> x - y end)
    |> Enum.sum()
  end
end

defmodule Day8.Parser do
  @moduledoc """
  Parser module.
  """

  @doc """
  Parses a given `line` string.

  Returns a list of two numbers, where the first number is number of string
  literal characters and the second is a number of characters in memory.

  # Examples

      iex> Parser.parse(~s("abc"))
      [9, 5]

  """
  def parse(line) do
    # Part 1
    # [
    #   String.length(line),
    #   line |> trim |> replace_hexadecimals |> replace_escaped_chars |> String.length()
    # ]
    [line |> escape |> String.length(), String.length(line)]
  end

  def escape(line) do
    line
    |> String.replace(~r/^"/, "...")
    |> String.replace(~r/"$/, "...")
    |> String.replace(~r/\\\\/, "....")
    |> String.replace(~r/\\\"/, "....")
    |> String.replace(~r/\\x[0-9a-fA-F]{2}/, ".....")
  end

  # def trim(line) do
  #   String.slice(line, 1..-2//1)
  # end

  # def replace_hexadecimals(line) do
  #   String.replace(line, ~r/\\x[0-9a-fA-F]{2}/, ".")
  # end

  # def replace_escaped_chars(line) do
  #   String.replace(line, ~r/\\[\\\"]/, ".")
  # end
end
