defmodule Day13 do
  defmodule Puzzle do
    alias Day13.Parser, as: Parser

    def solve do
      {edges, orders} =
        "lib/puzzles/13/input.txt"
        |> File.stream!()
        |> Enum.map(&Parser.parse/1)
        |> then(&{Parser.get_edges(&1), Parser.get_vertices(&1) |> seat})

      orders
      |> Enum.map(&calculate_happiness(edges, &1))
      |> Enum.sort()
      |> List.last()
    end

    @spec seat([atom()]) :: [[atom()], ...]
    def seat(vertices) do
      vertices |> of |> Enum.map(&[List.last(&1) | &1])
    end

    @spec calculate_happiness(%{{atom(), atom()} => integer()}, [atom(), ...]) :: integer()
    def calculate_happiness(edges, order) do
      order
      |> Enum.with_index()
      |> Enum.reduce(0, fn {seat, idx}, acc ->
        next = Enum.at(order, idx + 1)
        acc + Map.get(edges, {seat, next}, 0) + Map.get(edges, {next, seat}, 0)
      end)
    end

    defp of([]) do
      [[]]
    end

    defp of(list) do
      for x <- list, y <- of(list -- [x]), do: [x | y]
    end
  end

  defmodule Parser do
    def parse(str) do
      str
      |> String.split()
      |> then(&{{from(&1), to(&1)}, delta(&1)})
    end

    def get_edges(list) do
      Enum.reduce(list, %{}, fn {k, v}, acc -> Map.update(acc, k, v, & &1) end)
    end

    def get_vertices(list) do
      list
      |> Enum.reduce(MapSet.new(), fn x, acc ->
        vs = elem(x, 0)

        MapSet.put(acc, elem(vs, 0)) |> MapSet.put(elem(vs, 1)) |> MapSet.put(:Me)
      end)
      |> MapSet.to_list()
    end

    defp from(words) do
      words |> Enum.at(0) |> String.to_atom()
    end

    defp to(words) do
      words |> Enum.at(-1) |> String.replace_trailing(".", "") |> String.to_atom()
    end

    defp delta(words) do
      val = words |> Enum.at(3) |> String.to_integer()

      if words |> Enum.at(2) == "gain" do
        val
      else
        -val
      end
    end
  end
end
