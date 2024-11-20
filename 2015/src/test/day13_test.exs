defmodule Day13Test do
  use ExUnit.Case
  doctest Day13.Puzzle

  test "it translates an input string into a map entry" do
    assert Day13.Parser.parse("Alice would gain 54 happiness units by sitting next to Bob.") ==
             {{:Alice, :Bob}, 54}

    assert Day13.Parser.parse("Eric would lose 98 happiness units by sitting next to David.") ==
             {{:Eric, :David}, -98}
  end

  test "it seats every possible arrangements" do
    # Alice would gain 54 happiness units by sitting next to Bob.
    # Alice would lose 79 happiness units by sitting next to Carol.
    # Alice would lose 2 happiness units by sitting next to David.
    # Bob would gain 83 happiness units by sitting next to Alice.
    # Bob would lose 7 happiness units by sitting next to Carol.
    # Bob would lose 63 happiness units by sitting next to David.
    # Carol would lose 62 happiness units by sitting next to Alice.
    # Carol would gain 60 happiness units by sitting next to Bob.
    # Carol would gain 55 happiness units by sitting next to David.
    # David would gain 46 happiness units by sitting next to Alice.
    # David would lose 7 happiness units by sitting next to Bob.
    # David would gain 41 happiness units by sitting next to Carol.
    assert Day13.Puzzle.seat([:Alice, :Bob, :Carol, :David]) == [
             [:David, :Alice, :Bob, :Carol, :David],
             [:Carol, :Alice, :Bob, :David, :Carol],
             [:David, :Alice, :Carol, :Bob, :David],
             [:Bob, :Alice, :Carol, :David, :Bob],
             [:Carol, :Alice, :David, :Bob, :Carol],
             [:Bob, :Alice, :David, :Carol, :Bob],
             [:David, :Bob, :Alice, :Carol, :David],
             [:Carol, :Bob, :Alice, :David, :Carol],
             [:David, :Bob, :Carol, :Alice, :David],
             [:Alice, :Bob, :Carol, :David, :Alice],
             [:Carol, :Bob, :David, :Alice, :Carol],
             [:Alice, :Bob, :David, :Carol, :Alice],
             [:David, :Carol, :Alice, :Bob, :David],
             [:Bob, :Carol, :Alice, :David, :Bob],
             [:David, :Carol, :Bob, :Alice, :David],
             [:Alice, :Carol, :Bob, :David, :Alice],
             [:Bob, :Carol, :David, :Alice, :Bob],
             [:Alice, :Carol, :David, :Bob, :Alice],
             [:Carol, :David, :Alice, :Bob, :Carol],
             [:Bob, :David, :Alice, :Carol, :Bob],
             [:Carol, :David, :Bob, :Alice, :Carol],
             [:Alice, :David, :Bob, :Carol, :Alice],
             [:Bob, :David, :Carol, :Alice, :Bob],
             [:Alice, :David, :Carol, :Bob, :Alice]
           ]
  end

  test "it calculates happiness for a seating order" do
    assert Day13.Puzzle.calculate_happiness(
             %{
               {:Alice, :Bob} => 54,
               {:Alice, :Carol} => -79,
               {:Alice, :David} => -2,
               {:Bob, :Alice} => 83,
               {:Bob, :Carol} => -7,
               {:Bob, :David} => -63,
               {:Carol, :Alice} => -62,
               {:Carol, :Bob} => 60,
               {:Carol, :David} => 55,
               {:David, :Alice} => 46,
               {:David, :Bob} => -7,
               {:David, :Carol} => 41
             },
             [:Alice, :David, :Carol, :Bob, :Me, :Alice]
           ) == -2 + 41 + 60 + 0 + 0 + 0 + 0 + -7 + 55 + 46
  end

  test "it gets the edges for the graph" do
    assert Day13.Parser.get_edges([{{:Alice, :Bob}, 54}, {{:Eric, :David}, -98}]) ==
             %{{:Alice, :Bob} => 54, {:Eric, :David} => -98}
  end

  test "it gets the vertices for the graph" do
    assert Day13.Parser.get_vertices([{{:Alice, :Bob}, 54}, {{:Eric, :David}, -98}]) ==
             [:Alice, :Bob, :Eric, :David, :Me]
  end
end
