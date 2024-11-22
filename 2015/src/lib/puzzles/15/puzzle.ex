# Kind of slow
defmodule Day15 do
  defmodule Puzzle do
    def solve(spoons) do
      ingredients =
        "lib/puzzles/15/input.txt"
        |> File.stream!()
        |> Enum.map(&parse/1)

      capacities = ingredients |> Enum.map(& &1[:capacity])
      durabilities = ingredients |> Enum.map(& &1[:durability])
      flavors = ingredients |> Enum.map(& &1[:flavor])
      textures = ingredients |> Enum.map(& &1[:texture])
      calories = ingredients |> Enum.map(& &1[:calories])

      for a <- 0..spoons, b <- 0..spoons, c <- 0..spoons, d <- 0..spoons do
        if a + b + c + d == spoons do
          # part 1
          # score_recipe(capacities, durabilities, flavors, textures, [a, b, c, d])
          # part 2
          score_recipe(capacities, durabilities, flavors, textures, calories, [a, b, c, d])
        else
          0
        end
      end
      |> Enum.max()
    end

    def score_recipe(capacities, durabilities, flavors, textures, spoons) do
      score =
        [
          capacities |> sum_trait(spoons),
          durabilities |> sum_trait(spoons),
          flavors |> sum_trait(spoons),
          textures |> sum_trait(spoons)
        ]
        |> Enum.product()

      score
    end

    def score_recipe(capacities, durabilities, flavors, textures, calories, spoons) do
      score =
        {[
           capacities |> sum_trait(spoons),
           durabilities |> sum_trait(spoons),
           flavors |> sum_trait(spoons),
           textures |> sum_trait(spoons)
         ], calories |> sum_trait(spoons)}

      if elem(score, 1) == 500 do
        elem(score, 0) |> Enum.product()
      else
        0
      end
    end

    def sum_trait(traits, spoons) do
      total =
        for x <- 0..(length(spoons) - 1) do
          with trait <- Enum.at(traits, x), spoon <- Enum.at(spoons, x) do
            trait * spoon
          end
        end
        |> Enum.sum()

      if total < 0 do
        0
      else
        total
      end
    end

    def parse(line) do
      Regex.run(
        ~r/(\w+): capacity (-*\d+), durability (-*\d+), flavor (-*\d+), texture (-*\d+), calories (-*\d+)/,
        line
      )
      |> then(
        &%{
          name: Enum.at(&1, 1) |> String.to_atom(),
          capacity: Enum.at(&1, 2) |> String.to_integer(),
          durability: Enum.at(&1, 3) |> String.to_integer(),
          flavor: Enum.at(&1, 4) |> String.to_integer(),
          texture: Enum.at(&1, 5) |> String.to_integer(),
          calories: Enum.at(&1, 6) |> String.to_integer()
        }
      )
    end
  end
end
