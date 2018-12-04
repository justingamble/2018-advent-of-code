defmodule Input do
  defstruct claim_id: nil, x: 0, y: 0, length: 0, height: 0
end

#defmodule Coordinate do
#  @enforce_keys [:x, :y]
#  defstruct x: 0, y: 0
#  def new(x, y) do
#    {:ok, %Coordinate{x: x, y: y}}
#  end
#end

#defmodule Matrix do
#  @enforce_keys [:coordinates, :conflicts]
#  defstruct [:coordinates, :conflicts]
#  def new() do
#    %Matrix{coordinates: MapSet.new(), conflicts: MapSet.new()}
#  end
#end
#
defmodule Day3 do

    import Input

    def overlapped_squares(lines) do
      lines
      |> get_structured_input
      |> get_all_coordinates_in_use
      |> complete_matrix
      |> Enum.filter(fn {_key, value} -> value == :conflict end)
      |> Enum.count()
    end

    def complete_matrix(coordinates) do
      matrix = coordinates
               |> Enum.reduce(%{}, fn coordinate, m ->
                    Map.update(m, coordinate, :ok, fn _ -> :conflict end)
                  end)
      IO.inspect(matrix, label: "matrix")
      matrix
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
      |> IO.inspect(label: "all coordinates")
    end

    def convert_to_coordinates(%Input{x: x, y: y, length: length, height: height}) do
        right_x = x + length - 1
        bottom_y = y + height - 1
        list = for row <- x..right_x, column <- y..bottom_y do
          {row, column}
        #  Coordinate.new(row, column)
        end
        IO.inspect(list, label: "Coordinates for x=#{x}, y=#{y}, length=#{length}, height=#{height}")
    end


end


case System.argv() do
  ["--test"] ->
    ExUnit.start()

    defmodule Day3Test do
       use ExUnit.Case

       import Day3

       test "a" do
	   assert overlapped_squares("""
	   a
	   b
	   """) == 2
       end
    end
  [input_file] ->
    input_file
    |> File.read!()
    |> Day3.overlapped_squares()
    |> IO.inspect()

  _ -> IO.puts :stderr, "we expected --test or an input file"
end
