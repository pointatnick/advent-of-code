defmodule Day9Test do
  defmodule PuzzleTest do
    use ExUnit.Case
    doctest Day9.Puzzle

    test "it finds the longest distance" do
      input = ["London to Dublin = 464", "London to Belfast = 518", "Dublin to Belfast = 141"]
      assert Day9.Puzzle.solve(input) == 982
    end
  end

  defmodule ParserTest do
    use ExUnit.Case
    alias Day9.Parser, as: Parser

    doctest Parser

    test "parses a string into a map of start to map of end and distance" do
      str = "London to Dublin = 464"
      assert Parser.parse(str) == {:London, :Dublin, 464}
    end
  end

  defmodule NavigatorTest do
    use ExUnit.Case
    alias Day9.Navigator, as: Navigator

    doctest Navigator

    test "it creates a graph from edges" do
      edges = [{:London, :Dublin, 464}, {:London, :Belfast, 518}, {:Dublin, :Belfast, 141}]

      assert Navigator.graph(edges) == {
               %{
                 MapSet.new([:London, :Belfast]) => 518,
                 MapSet.new([:London, :Dublin]) => 464,
                 MapSet.new([:Dublin, :Belfast]) => 141
               },
               MapSet.new([:London, :Belfast, :Dublin])
             }
    end

    test "it finds all possible paths in the graph" do
      graph =
        {%{
           MapSet.new([:London, :Belfast]) => 518,
           MapSet.new([:London, :Dublin]) => 464,
           MapSet.new([:Dublin, :Belfast]) => 141
         }, MapSet.new([:London, :Belfast, :Dublin])}

      assert Navigator.pathfind(graph) ==
               {%{
                  MapSet.new([:London, :Belfast]) => 518,
                  MapSet.new([:London, :Dublin]) => 464,
                  MapSet.new([:Dublin, :Belfast]) => 141
                },
                [
                  [:London, :Dublin, :Belfast],
                  [:London, :Belfast, :Dublin],
                  [:Dublin, :London, :Belfast],
                  [:Dublin, :Belfast, :London],
                  [:Belfast, :London, :Dublin],
                  [:Belfast, :Dublin, :London]
                ]}
    end

    test "it traverses the graph and gets total distances" do
      graph =
        {%{
           MapSet.new([:London, :Belfast]) => 518,
           MapSet.new([:London, :Dublin]) => 464,
           MapSet.new([:Dublin, :Belfast]) => 141
         },
         [
           [:London, :Dublin, :Belfast],
           [:London, :Belfast, :Dublin],
           [:Dublin, :London, :Belfast],
           [:Dublin, :Belfast, :London],
           [:Belfast, :London, :Dublin],
           [:Belfast, :Dublin, :London]
         ]}

      assert Navigator.traverse(graph) == [605, 659, 982, 659, 982, 605]
    end
  end
end
