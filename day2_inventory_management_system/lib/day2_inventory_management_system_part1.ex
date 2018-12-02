defmodule Day2InventoryManagementSystemPart1 do
  @moduledoc """
  Documentation for Day2InventoryManagementSystem.
  """
  alias Counter

  def main(input_file) do
    final_state =
      File.stream!(input_file)
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Enum.reduce(%Counter{}, &count_chars/2)

    checksum = final_state.two_chars * final_state.three_chars

    IO.puts(
      "Found #{final_state.two_chars} two-char sequences, #{final_state.three_chars} three-char sequences"
    )

    IO.puts("Checksum=#{checksum}")
    final_state
  end

  def count_chars(
        scan_string,
        state = %Counter{two_chars: curr_two_chars, three_chars: curr_three_chars}
      ) do
    clean_string = scan_string |> String.trim()
    map = do_count(%{}, clean_string)

    two_chars = count_two_chars(map)
    three_chars = count_three_chars(map)
    %{state | two_chars: curr_two_chars + two_chars, three_chars: curr_three_chars + three_chars}
  end

  # Returns 1 if map has at least one character repeating 2-times exactly.
  # Returns 0 otherwise.
  def count_two_chars(map) do
    count =
      Enum.filter(map, fn {_key, value} -> value == 2 end)
      |> Enum.count()

    if count > 0 do
      1
    else
      0
    end
  end

  # Returns 1 if map has at least one character repeating 2-times exactly.
  # Returns 0 otherwise.
  def count_three_chars(map) do
    count =
      Enum.filter(map, fn {_key, value} -> value == 3 end)
      |> Enum.count()

    if count > 0 do
      1
    else
      0
    end
  end

  def do_count(map, "") do
    map
  end

  def do_count(map, rest) do
    {c, new_rest} = String.next_codepoint(rest)
    new_map = add_to_map(map, c)
    do_count(new_map, new_rest)
  end

  def add_to_map(map, c) do
    Map.update(
      # look in this map
      map,
      # for an entry with key
      c,
      # if not found, store this value
      1,
      # else update with the result of this fn
      fn existing -> existing + 1 end
    )
  end
end
