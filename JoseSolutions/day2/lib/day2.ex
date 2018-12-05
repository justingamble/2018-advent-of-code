defmodule Day2 do

  def main() do
    File.read!("input.txt")
    |> String.split("\n", trim: true)
    |> Day2.checksum()
  end

  def checksum(list) when is_list(list) do
    {twice, thrice} =
      Enum.reduce(list, {0, 0}, fn box_id, {total_twice, total_thrice} ->
        {twice, thrice} = box_id |> count_characters() |> get_twice_and_thrice()
        {twice + total_twice, thrice + total_thrice}
      end)

    twice * thrice
  end

  def get_twice_and_thrice(characters) when is_map(characters) do
    Enum.reduce(characters, {0, 0}, fn
      {_codepoint, 2}, {_twice, thrice} -> {1, thrice}
      {_codepoint, 3}, {twice, _thrice}  -> {twice, 1}
      _, acc -> acc
    end)
  end

  def count_characters(string) when is_binary(string) do
    string
    |> String.to_charlist()
    |> Enum.reduce(%{}, fn codepoint, acc ->
      Map.update(acc, codepoint, 1, &(&1 + 1))
    end)
  end

## Alternate approach, if you wanted to support UTF8 characters:
#
#  def count_characters(string) when is_binary(string) do
#    count_characters(string, %{})
#  end
#
#  defp count_characters(<<codepoint::utf8, rest::binary>>, acc) do
#    acc = Map.update(acc, codepoint, 1, &(&1 + 1))
#    count_characters(rest, acc)
#  end
#
#  defp count_characters(<<>>, acc) do
#    acc
#  end
end
