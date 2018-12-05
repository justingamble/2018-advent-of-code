defmodule Input do
  defstruct claim_id: nil, x: 0, y: 0, length: 0, height: 0
end

defmodule Day3 do
  import Input

  def find_single_claim(lines) do
    structured_input = lines |> get_structured_input

    all_claim_ids =
      structured_input
      |> Enum.reduce(%MapSet{}, fn %Input{} = input, acc -> MapSet.put(acc, input.claim_id) end)

    matrix =
      structured_input
      |> get_all_coordinates_in_use
      |> complete_matrix

    conflict_claim_ids =
      matrix
      |> Enum.filter(fn {_k, v} ->
        case v do
          {:conflict, _} -> true
          _ -> false
        end
      end)
      |> Enum.reduce(%MapSet{}, fn {_k, v}, acc ->
        {:conflict, list} = v

        new_mapset =
          list
          |> Enum.reduce(%MapSet{}, fn elem, acc2 ->
            MapSet.put(acc2, elem)
          end)

        MapSet.union(acc, new_mapset)
      end)

    sole_survivor = MapSet.difference(all_claim_ids, conflict_claim_ids)
    list = MapSet.to_list(sole_survivor)
    {x, []} = List.pop_at(list, 0)
    x
  end

  def complete_matrix(coordinates) do
    _matrix =
      coordinates
      |> Enum.reduce(%{}, fn {claim_id, x, y}, map_acc ->
        Map.update(map_acc, {x, y}, {:ok, [claim_id]}, fn prev ->
          merge_claim_ids(prev, claim_id)
        end)
      end)
  end

  def merge_claim_ids(old, new) do
    case old do
      {:ok, list} -> {:conflict, [new | list]}
      {:conflict, list} -> {:conflict, [new | list]}
      _ -> raise "ERROR: 'old' (#{inspect(old)}) not matched"
    end
  end

  def get_structured_input(lines) do
    lines
    |> String.split("\n", trim: true)
    |> Enum.map(&make_structure(&1))
  end

  def make_structure(string) do
    %Input{} = deconstruct_line(string)
  end

  def deconstruct_line(line) do
    regex = ~r/#(\d+)\s*@\s*(\d+),(\d+):\s*(\d+)x(\d+)/
    [_, claim_id, x, y, length, height] = Regex.run(regex, line)

    %Input{
      claim_id: String.to_integer(claim_id),
      x: String.to_integer(x),
      y: String.to_integer(y),
      length: String.to_integer(length),
      height: String.to_integer(height)
    }
  end

  def get_all_coordinates_in_use(list_of_structs) do
    list_of_structs
    |> Enum.map(&convert_to_coordinates/1)
    |> List.flatten()
  end

  def convert_to_coordinates(%Input{
        claim_id: claim_id,
        x: x,
        y: y,
        length: length,
        height: height
      }) do
    right_x = x + length - 1
    bottom_y = y + height - 1

    for row <- x..right_x, column <- y..bottom_y do
      {claim_id, row, column}
    end
  end
end

case System.argv() do
  [input_file] ->
    input_file
    |> File.read!()
    |> Day3.find_single_claim()
    |> IO.inspect(label: "Final answer")

  _ ->
    IO.puts(:stderr, "ERROR: expected an input file")
end
