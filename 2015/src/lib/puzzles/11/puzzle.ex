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

  defmodule Password do
    @spec increment([integer()]) :: [integer()]
    def increment(charlist) do
      # ailoz
      # [97, 105, 108, 111, 122]
      {last_char, rest} = List.pop_at(charlist, -1)

      if last_char == 122 && Enum.empty?(rest) do
        [97]
      else
        if last_char == 122 do
          increment(rest) ++ [97]
        else
          incremented =
            cond do
              last_char in [104, 107, 110] -> last_char + 2
              true -> last_char + 1
            end

          rest ++ [incremented]
        end
      end
    end

    @spec valid?(String.t()) :: boolean()
    def valid?(str) do
      # - Passwords must include one increasing straight of at least three letters, like abc, bcd,
      # cde, and so on, up to xyz. They cannot skip letters; abd doesn't count.
      # - Passwords may not contain the letters i, l, or o, as these letters can be mistaken for
      # other characters and are therefore confusing.
      # - Passwords must contain at least two different, non-overlapping pairs of letters, like aa,
      # bb, or zz.
      has_straight?(str) && !String.contains?(str, ["i", "l", "o"]) && has_two_pairs(str)
    end

    defp has_two_pairs(str) do
      String.match?(str, ~r/([abcdefghjkmnpqrstuvwxyz])\1.*(?!\1)([abcdefghjkmnpqrstuvwxyz])\2/)
    end

    defp has_straight?(str) do
      String.match?(
        str,
        ~r/(abc)|(bcd)|(cde)|(def)|(efg)|(fgh)|(pqr)|(qrs)|(rst)|(stu)|(tuv)|(uvw)|(vwx)|(wxy)|(xyz)/
      )
    end
  end
end
