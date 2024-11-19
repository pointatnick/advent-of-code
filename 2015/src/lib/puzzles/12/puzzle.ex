defmodule Day12 do
  defmodule Puzzle do
    alias Day12.Parser, as: Parser
    # JSON only supports 6 data types:
    # String
    # Number
    # Boolean
    # Null
    # Object
    # Array

    def solve(filename) do
      File.read!(filename) |> Jason.decode!() |> Parser.sum()
    end
  end

  defmodule Parser do
    @spec sum(arg) :: integer() when arg: integer()
    def sum(input) when is_integer(input) do
      input
    end

    @spec sum(arg) :: integer() when arg: [any()]
    def sum(input) when is_list(input) do
      input |> Enum.map(&sum/1) |> Enum.sum()
    end

    @spec sum(arg) :: integer() when arg: %{optional(String.t()) => any()}
    def sum(input) when is_map(input) do
      if "red" in Map.values(input) do
        0
      else
        input |> Enum.map(fn {_k, v} -> sum(v) end) |> Enum.sum()
      end
    end

    @spec sum(any()) :: integer()
    def sum(_input) do
      0
    end
  end
end
