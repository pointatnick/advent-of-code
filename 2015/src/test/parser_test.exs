defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  # Part 1
  # test "parses an empty string" do
  #   assert Parser.parse("\"\"") == [2, 0]
  # end

  # test "parses a string" do
  #   assert Parser.parse("\"abc\"") == [5, 3]
  # end

  # test "parses a string with escaped characters" do
  #   assert Parser.parse("\"aaa\\\"aaa\"") == [10, 7]
  # end

  # test "parses a string with escaped hexadecimal" do
  #   assert Parser.parse("\"\\x27\"") == [6, 1]
  # end

  # Part 2
  test "parses an empty string" do
    assert Parser.parse("\"\"") == [6, 2]
  end

  test "parses a string" do
    assert Parser.parse("\"abc\"") == [9, 5]
  end

  test "parses a string with escaped characters" do
    assert Parser.parse("\"aaa\\\"aaa\"") == [16, 10]
  end

  test "parses a string with escaped hexadecimal" do
    assert Parser.parse("\"\\x27\"") == [11, 6]
  end
end
