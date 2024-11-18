defmodule Day11 do
  defmodule Puzzle do
    alias Day11.Password, as: Password
    # Puzzle: "cqjxjnds"

    def solve(str) do
      pw = str |> String.to_charlist() |> Password.increment() |> List.to_string()

      if Password.valid?(pw) do
        pw
      else
        solve(pw)
      end
    end
  end

  defmodule Parser do
  end
end
