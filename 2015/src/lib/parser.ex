defmodule Parser do
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
    IO.puts("parsing #{line}")

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
