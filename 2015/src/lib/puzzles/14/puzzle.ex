defmodule Day14 do
  defmodule Puzzle do
    alias Day14.Parser, as: Parser

    def solve do
      # Pt 1
      race_history =
        "lib/puzzles/14/input.txt"
        |> File.stream!()
        |> Enum.map(&Parser.parse/1)
        |> Enum.map(&race(&1, 2503))
        |> Enum.reduce(%{}, &Map.merge/2)
        |> Map.values()
        |> Enum.map(
          &Enum.reduce(&1, [], fn cur, acc ->
            if Enum.empty?(acc) do
              [cur]
            else
              [cur + hd(acc) | acc]
            end
          end)
        )

      race_by_total =
        race_history
        |> Enum.map(&hd/1)
        |> Enum.max()

      score(race_history, 2503)
      |> Enum.reduce(List.duplicate(0, 9), fn cur, acc ->
        [
          Enum.at(acc, 0) + Enum.at(cur, 0),
          Enum.at(acc, 1) + Enum.at(cur, 1),
          Enum.at(acc, 2) + Enum.at(cur, 2),
          Enum.at(acc, 3) + Enum.at(cur, 3),
          Enum.at(acc, 4) + Enum.at(cur, 4),
          Enum.at(acc, 5) + Enum.at(cur, 5),
          Enum.at(acc, 6) + Enum.at(cur, 6),
          Enum.at(acc, 7) + Enum.at(cur, 7),
          Enum.at(acc, 8) + Enum.at(cur, 8)
        ]
      end)
      |> Enum.max()
    end

    def score(history, seconds) do
      for x <- 0..(seconds - 1) do
        distances_by_second = history |> Enum.map(&(List.pop_at(&1, x) |> elem(0)))
        max_dist = Enum.max(distances_by_second)

        distances_by_second
        |> Enum.map(&if &1 == max_dist, do: 1, else: 0)
      end
    end

    def race(state, seconds) do
      (List.duplicate(Map.get(state, :rate), Map.get(state, :duration)) ++
         List.duplicate(0, Map.get(state, :break)))
      |> Stream.cycle()
      |> then(&%{Map.get(state, :name) => Enum.take(&1, seconds)})
    end
  end

  defmodule Parser do
    def parse(str) do
      Regex.run(
        ~r"(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds.",
        str
      )
      |> then(
        &%{
          name: Enum.at(&1, 1) |> String.to_atom(),
          rate: Enum.at(&1, 2) |> String.to_integer(),
          duration: Enum.at(&1, 3) |> String.to_integer(),
          break: Enum.at(&1, 4) |> String.to_integer()
        }
      )
    end

    def map_stats(lines) do
      lines
    end
  end
end
