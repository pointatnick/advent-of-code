defmodule Day16 do
  defmodule Puzzle do
    def solve do
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

      "lib/puzzles/16/input.txt"
      |> File.stream!()
      |> Enum.map(&parse/1)
      |> Enum.map(fn map ->
        {sue, map_without_sue} = Map.split(map, [:sue_num])
        {sue, has_match?(sample, map_without_sue)}
      end)
      |> Enum.filter(&(&1 |> elem(1)))
    end

    def parse(line) do
      ~r/Sue (\d+): (\w+): (\d+), (\w+): (\d+), (\w+): (\d+)/
      |> Regex.run(line)
      |> then(
        &%{
          (Enum.at(&1, 2) |> String.to_atom()) => Enum.at(&1, 3) |> String.to_integer(),
          (Enum.at(&1, 4) |> String.to_atom()) => Enum.at(&1, 5) |> String.to_integer(),
          (Enum.at(&1, 6) |> String.to_atom()) => Enum.at(&1, 7) |> String.to_integer(),
          sue_num: Enum.at(&1, 1) |> String.to_integer()
        }
      )
    end

    # Part 1 match
    # def has_match?(map1, map2) do
    #   map2 |> Map.to_list() |> Enum.map(fn {k, v} -> Map.get(map1, k) == v end) |> Enum.all?()
    # end

    def has_match?(map1, map2) do
      map2
      |> Map.to_list()
      |> Enum.map(fn {k, v} ->
        cond do
          k in [:cats, :trees] -> v > Map.get(map1, k)
          k in [:pomeranians, :goldfish] -> v < Map.get(map1, k)
          true -> Map.get(map1, k) == v
        end
      end)
      |> Enum.all?()
    end
  end
end
