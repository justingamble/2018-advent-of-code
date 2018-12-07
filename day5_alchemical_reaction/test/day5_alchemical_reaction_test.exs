defmodule Day5AlchemicalReactionTest do
  use ExUnit.Case

  test "no more reduction of: aBcD" do
    assert String.equivalent?(Day5AlchemicalReaction.find_shortest_polymer("aBcD"), "aBcD")
  end

  test "no more reduction of: aAcD" do
    assert String.equivalent?(Day5AlchemicalReaction.find_shortest_polymer("aAcD"), "cD")
  end

  test "sample input: 'dabAcCaCBAcCcaDA' -> 'dabCBAcaDA'" do
    assert String.equivalent?(
             Day5AlchemicalReaction.find_shortest_polymer("dabAcCaCBAcCcaDA"),
             "dabCBAcaDA"
           )
  end

  @tag :only
  test "sample input: 'abBA' -> ''" do
    assert String.equivalent?(
             Day5AlchemicalReaction.find_shortest_polymer("abBA"),
             ""
           )
  end
end
