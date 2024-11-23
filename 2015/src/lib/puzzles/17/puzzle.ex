defmodule Day17 do
  defmodule Puzzle do
    def solve do
      "lib/puzzles/17/input.txt"
      |> File.stream!()
      |> Enum.map(&parse/1)
      |> Enum.sort(:desc)
      # Part 1
      # |> pour(150)
      # Part 2
      |> pour(150, 0)
    end

    # Part 1
    def pour(containers, remaining) do
      cond do
        remaining == 0 ->
          1

        length(containers) == 0 ||
          remaining < Enum.min(containers) ||
            remaining > Enum.sum(containers) ->
          0

        true ->
          [hd | tl] = containers
          pour(tl, remaining) + pour(tl, remaining - hd)
      end
    end

    # Part 2: Return %{num_containers => ways to use num_containers}
    def pour(containers, remaining, num_containers_used) do
      cond do
        remaining == 0 ->
          %{num_containers_used => 1}

        length(containers) == 0 ||
          remaining < Enum.min(containers) ||
            remaining > Enum.sum(containers) ->
          %{}

        true ->
          [hd | tl] = containers

          Map.merge(
            pour(tl, remaining, num_containers_used),
            pour(tl, remaining - hd, num_containers_used + 1),
            fn _k, v1, v2 -> v1 + v2 end
          )
      end
    end

    def parse(line) do
      ~r/(\d+)/
      |> Regex.run(line)
      |> hd
      |> String.to_integer()
    end
  end
end
