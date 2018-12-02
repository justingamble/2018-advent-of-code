defmodule Day2InventoryManagementSystemPart2 do
  @moduledoc """
  Documentation for Day2InventoryManagementSystem.
  """
  def main(input_file) do
    lines =
      File.stream!(input_file)
      |> Stream.map(&String.trim/1)
      |> Enum.to_list()

    ScoreAgent.start_link()
    find_the_two_most_similar_strings(lines)
    common_chars = extract_common_chars_from_ScoreAgent()
    IO.puts("Letters common in box IDs: #{inspect common_chars}")
  end

  # Extracts and returns the common characters as stored in ScoreAgent
  def extract_common_chars_from_ScoreAgent() do
    {string1, string2} = ScoreAgent.get_strings()
    String.myers_difference(string1, string2)
      |> Enum.filter( fn {key, _value} -> String.equivalent?(to_string(key), "eq") end )
      |> Enum.map( fn {_key, value} -> value end )
      |> Enum.join()
  end

  # The result of this function is an updated ScoreAgent process
  def find_the_two_most_similar_strings(lines) do
    # brute-force test each string against each other string
    # we could optimize this; presently each string-pair is compared twice
    for string1 <- lines do
      for string2 <- lines do
        if string1 != string2 do
          score = String.jaro_distance(string1, string2)
          if score > ScoreAgent.get_score() do
              ScoreAgent.set_score(score, string1, string2)
          end
        end
      end
    end
  end
end
