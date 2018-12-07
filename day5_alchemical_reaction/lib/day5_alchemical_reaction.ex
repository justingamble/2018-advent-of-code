defmodule Day5AlchemicalReaction do
  def main(input_file) do
    answer = File.read!(input_file)
      |> String.split("\n", trim: true)
      |> Enum.at(0)
      |> find_shortest_polymer

    IO.puts("Final answer: #{String.length(answer)}")
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
