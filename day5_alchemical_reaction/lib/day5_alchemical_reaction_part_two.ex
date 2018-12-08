defmodule Day5AlchemicalReactionPartTwo do
  def main(input_file) do
    File.read!(input_file)
    |> String.split("\n", trim: true)
    |> Enum.at(0)
    |> get_list_of_polymer_sequences()
    |> get_length_of_best_sequence_removal()
    |> IO.inspect(label: "Final answer")
  end

  def get_list_of_polymer_sequences(input_string) when is_binary(input_string) do
    for char <- ?a..?z do
      new_string = remove_unit(input_string, char)
      new_string
    end
  end

  def remove_unit(binary, char_to_remove) when is_binary(binary) and char_to_remove in ?A..?z do
    char_list = String.to_charlist(binary)

    updated_list =
      Enum.reject(char_list, fn x ->
        test_char = List.to_string([x])
        string_char_to_remove = List.to_string([char_to_remove])
        String.equivalent?(String.upcase(test_char), String.upcase(string_char_to_remove))
      end)

    List.to_string(updated_list)
  end

  def remove_unit(char_list, char_to_remove) when is_binary(char_to_remove) do
    Enum.reject(char_list, fn x ->
      test_char = List.to_string([x])
      String.equivalent?(String.upcase(test_char), String.upcase(char_to_remove))
    end)
  end

  def remove_unit(char_list, char_to_remove) when char_to_remove in ?A..?z do
    remove_unit(char_list, List.to_string([char_to_remove]))
  end

  def get_length_of_best_sequence_removal(list_of_polymer_sequences)
      when is_list(list_of_polymer_sequences) do
    list_of_polymer_sequences
    |> Enum.map(fn sequence ->
      Task.async(Day5AlchemicalReactionPartTwo, :get_polymer_length, [sequence])
    end)
    |> Enum.map(&Task.await(&1, :infinity))
    |> Enum.min()
  end

  def get_polymer_length(input_string) do
    find_shortest_polymer(input_string)
    |> String.length()
  end

  def find_shortest_polymer(string) do
    case test_even(string) do
      {:change, new_string} ->
        find_shortest_polymer(new_string)

      _ ->
        case test_odd(string) do
          {:change, new_string} ->
            find_shortest_polymer(new_string)

          _ ->
            string
        end
    end
  end

  def test_odd(string) do
    str_len = String.length(string)

    chunks_of_2 =
      String.slice(string, 1..(str_len - 1))
      |> String.to_charlist()
      |> Enum.chunk_every(2, 2)

    start_length = length(chunks_of_2)
    shorter_chunks_of_2 = react_polymers(chunks_of_2)
    end_length = length(shorter_chunks_of_2)

    if start_length == end_length do
      {:nochange, string}
    else
      {:change, String.slice(string, 0..0) <> to_string(List.flatten(shorter_chunks_of_2))}
    end
  end

  def test_even(string) do
    chunks_of_2 =
      String.to_charlist(string)
      |> Enum.chunk_every(2, 2)

    start_length = length(chunks_of_2)
    shorter_chunks_of_2 = react_polymers(chunks_of_2)
    end_length = length(shorter_chunks_of_2)

    if start_length == end_length do
      {:nochange, string}
    else
      {:change, to_string(List.flatten(shorter_chunks_of_2))}
    end
  end

  def react_polymers(list_of_pairs) do
    Enum.reject(list_of_pairs, &react(&1))
  end

  def react([a, b]) when a in ?A..?z and b in ?A..?z do
    char1 = List.to_string([a])
    char2 = List.to_string([b])
    same_char = String.downcase(char1) == String.downcase(char2)
    different_case = not String.equivalent?(char1, char2)
    same_char and different_case
  end

  # If there is an extra char at the end, after breaking in chunks of 2
  def react([_a]) do
    false
  end
end
