defmodule Input do
  defstruct claim_id: nil, x: 0, y: 0, length: 0, height: 0
end

defmodule Day3 do

    import Input

    def single_claim(lines) do
      matrix = lines
        |> get_structured_input
        |> get_all_coordinates_in_use
        |> complete_matrix

      all_claim_ids = matrix
        |> Enum.reduce(%MapSet{}, fn {key, _value}, acc -> MapSet.put(acc, key) end)
      IO.inspect(all_claim_ids, label: "all_claim_ids")
#      |> Enum.filter(fn {_key, value} -> value == :conflict end)
    end

    def complete_matrix(coordinates) do
      matrix = coordinates
               |> Enum.reduce(%{}, fn {claim_id, x, y}, map_acc ->
                    Map.update(map_acc, {x,y}, {:ok, [claim_id]}, fn prev -> merge_claim_ids(prev, claim_id) end)
                  end)
      IO.inspect(matrix, label: "matrix")
      matrix
    end

    def merge_claim_ids(old, new) do
      case old do
        {:ok, [tail]} -> {:conflict, [new | tail]}
        {:conflict, [tail]} -> {:conflict, [new | tail]}
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
       %Input{claim_id: String.to_integer(claim_id),
         x: String.to_integer(x),
         y: String.to_integer(y),
         length: String.to_integer(length),
         height: String.to_integer(height)}
    end

    def get_all_coordinates_in_use(list_of_structs) do
      list_of_structs
      |> Enum.map(&convert_to_coordinates/1)
      |> List.flatten
    end

    def convert_to_coordinates(%Input{claim_id: claim_id, x: x, y: y, length: length, height: height}) do
        right_x = x + length - 1
        bottom_y = y + height - 1
        for row <- x..right_x, column <- y..bottom_y do
          {claim_id, row, column}
        end
    end

end


case System.argv() do
#  ["--test"] ->
#    ExUnit.start()
#
#    defmodule Day3Test do
#       use ExUnit.Case
#
#       import Day3
#
#       test "a" do
#	   assert overlapped_squares("""
#	   a
#	   b
#	   """) == 2
#       end
#    end
  [input_file] ->
    input_file
    |> File.read!()
    |> Day3.single_claim()
    |> IO.inspect(label: "Final answer")

#  _ -> IO.puts :stderr, "we expected --test or an input file"
  _ -> IO.puts :stderr, "ERROR: expected an input file"
end
