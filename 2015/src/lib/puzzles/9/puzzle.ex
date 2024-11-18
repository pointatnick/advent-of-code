defmodule Day9 do
  defmodule Puzzle do
    def solve do
      "lib/puzzles/9/input.txt"
      |> File.stream!()
      |> Enum.map(&String.trim/1)
      |> solve
    end

    def solve(input) do
      input
      |> Enum.map(&Day9.Parser.parse/1)
      |> Day9.Navigator.graph()
      |> Day9.Navigator.pathfind()
      |> Day9.Navigator.traverse()
      |> Enum.sort()
      |> Enum.reverse()
      |> hd
    end
  end

  defmodule Navigator do
    @spec graph([{String.t(), String.t(), String.t()}]) :: {%{%MapSet{} => integer()}, %MapSet{}}
    def graph(edges) do
      {
        Enum.reduce(edges, Map.new(), &map_vertices/2),
        list_edges(edges)
      }
    end

    @spec traverse({%{%MapSet{} => integer()}, [[atom()]]}) :: [integer()]
    def traverse({edges, paths}) do
      paths
      |> Enum.map(fn p -> p |> measure(edges) |> Enum.sum() end)
    end

    def pathfind({edges, vertices}) do
      {edges, vertices |> MapSet.to_list() |> of}
    end

    defp measure(path, edges) do
      for x <- 0..(length(path) - 2),
          do: Map.get(edges, MapSet.new([Enum.at(path, x), Enum.at(path, x + 1)]))
    end

    defp of([]) do
      [[]]
    end

    defp of(list) do
      for x <- list, y <- of(list -- [x]), do: [x | y]
    end

    defp list_edges(edges) do
      froms = edges |> Enum.map(&elem(&1, 0))
      tos = edges |> Enum.map(&elem(&1, 1))
      (froms ++ tos) |> MapSet.new()
    end

    defp map_vertices(cur, acc) do
      {from, to, distance} = cur
      Map.update(acc, MapSet.new([from, to]), distance, & &1)
    end
  end

  defmodule Parser do
    def parse(line) do
      line
      |> String.replace(~r/ ((to)|=) /, ",")
      |> String.split(",")
      |> parse_edge
    end

    @spec parse_edge([String.t(), ...]) :: {atom(), atom(), integer()}
    def parse_edge(list) do
      [from, to, distance] = list
      {String.to_atom(from), String.to_atom(to), String.to_integer(distance)}
    end
  end
end
