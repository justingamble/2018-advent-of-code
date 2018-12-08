defmodule Day5AlchemicalReactionPartTwoTest do
  use ExUnit.Case

  test "process_permutation: correctly removes A from 'dabCBAcaDaCCAab'" do
    test_string = String.to_charlist("dabCBAcaDaCCAab")
    expect_string = "dbCBcDCCb"

    assert String.equivalent?(
             Day5AlchemicalReactionPartTwo.remove_unit(test_string, ?a) |> List.to_string(),
             expect_string
           )

    assert String.equivalent?(
             Day5AlchemicalReactionPartTwo.remove_unit(test_string, ?A) |> List.to_string(),
             expect_string
           )

    assert String.equivalent?(
             Day5AlchemicalReactionPartTwo.remove_unit(test_string, "a") |> List.to_string(),
             expect_string
           )

    assert String.equivalent?(
             Day5AlchemicalReactionPartTwo.remove_unit(test_string, "A") |> List.to_string(),
             expect_string
           )
  end

  test "get_list_of_polymer_sequences: 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'" do
    input_string = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    result_list = Day5AlchemicalReactionPartTwo.get_list_of_polymer_sequences(input_string)

    expect_list = [
      "bcdefghijklmnopqrstuvwxyzBCDEFGHIJKLMNOPQRSTUVWXYZ",
      "acdefghijklmnopqrstuvwxyzACDEFGHIJKLMNOPQRSTUVWXYZ",
      "abdefghijklmnopqrstuvwxyzABDEFGHIJKLMNOPQRSTUVWXYZ",
      "abcefghijklmnopqrstuvwxyzABCEFGHIJKLMNOPQRSTUVWXYZ",
      "abcdfghijklmnopqrstuvwxyzABCDFGHIJKLMNOPQRSTUVWXYZ",
      "abcdeghijklmnopqrstuvwxyzABCDEGHIJKLMNOPQRSTUVWXYZ",
      "abcdefhijklmnopqrstuvwxyzABCDEFHIJKLMNOPQRSTUVWXYZ",
      "abcdefgijklmnopqrstuvwxyzABCDEFGIJKLMNOPQRSTUVWXYZ",
      "abcdefghjklmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ",
      "abcdefghiklmnopqrstuvwxyzABCDEFGHIKLMNOPQRSTUVWXYZ",
      "abcdefghijlmnopqrstuvwxyzABCDEFGHIJLMNOPQRSTUVWXYZ",
      "abcdefghijkmnopqrstuvwxyzABCDEFGHIJKMNOPQRSTUVWXYZ",
      "abcdefghijklnopqrstuvwxyzABCDEFGHIJKLNOPQRSTUVWXYZ",
      "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ",
      "abcdefghijklmnpqrstuvwxyzABCDEFGHIJKLMNPQRSTUVWXYZ",
      "abcdefghijklmnoqrstuvwxyzABCDEFGHIJKLMNOQRSTUVWXYZ",
      "abcdefghijklmnoprstuvwxyzABCDEFGHIJKLMNOPRSTUVWXYZ",
      "abcdefghijklmnopqstuvwxyzABCDEFGHIJKLMNOPQSTUVWXYZ",
      "abcdefghijklmnopqrtuvwxyzABCDEFGHIJKLMNOPQRTUVWXYZ",
      "abcdefghijklmnopqrsuvwxyzABCDEFGHIJKLMNOPQRSUVWXYZ",
      "abcdefghijklmnopqrstvwxyzABCDEFGHIJKLMNOPQRSTVWXYZ",
      "abcdefghijklmnopqrstuwxyzABCDEFGHIJKLMNOPQRSTUWXYZ",
      "abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVXYZ",
      "abcdefghijklmnopqrstuvwyzABCDEFGHIJKLMNOPQRSTUVWYZ",
      "abcdefghijklmnopqrstuvwxzABCDEFGHIJKLMNOPQRSTUVWXZ",
      "abcdefghijklmnopqrstuvwxyABCDEFGHIJKLMNOPQRSTUVWXY"
    ]

    assert result_list -- expect_list == []
    assert expect_list -- result_list == []
  end

  test "sample input: dabAcCaCBAcCcaDa" do
    result =
      "dabAcCaCBAcCcaDa"
      |> Day5AlchemicalReactionPartTwo.get_list_of_polymer_sequences()
      |> Enum.uniq()
      |> Day5AlchemicalReactionPartTwo.get_length_of_best_sequence_removal()

    assert(result == 4)
  end
end
