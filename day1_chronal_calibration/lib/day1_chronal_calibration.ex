defmodule Day1ChronalCalibration do
  @moduledoc """
  We are not doing error checking on the input file.  We just assume each
  line starts with +/- and is followed by an integer and newline.
  """

  @initial_value 0

  @doc """
  part_one sums all the numbers in the input_file
  """
  def part_one(input_file) do
    File.stream!(input_file)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.reduce(@initial_value, &sum/2)
  end

  @doc """
  part_two processes the numbers in the input_file, and returns the
  first sum that is repeated twice.  The input_file may need to be
  processed multiple times before this happens.
  """
  def part_two(input_file) do
    seen_map = %{@initial_value => 1}
    process_part_two(input_file, @initial_value, seen_map)
  end

  defp process_part_two(input_file, current_sum, seen_map) do
    {status, result} = process_input_file(input_file, current_sum, seen_map)

    case status do
      :cont ->
        # IO.puts("(Continue again from the start of the input file)")
        {new_sum, new_seen_map} = result
        process_part_two(input_file, new_sum, new_seen_map)

      :ok ->
        result
    end
  end

  @doc """
  Return {:ok, sum} if we found the same calibration number twice.
  Return {:cont, {new_sum, seen_map}} otherwise
  """
  def process_input_file(input_file, current_sum, seen_map) do
    {result, new_seen_map} =
      File.stream!(input_file)
      |> Stream.map(&String.replace(&1, "\n", ""))
      |> Enum.reduce_while(
        {current_sum, seen_map},
        &Day1ChronalCalibration.sum_not_reached_twice/2
      )

    case found_duplicate(new_seen_map) do
      true -> {:ok, result}
      false -> {:cont, {result, new_seen_map}}
    end
  end

  @doc """
  Returns true if at least one item in the map has a value of "2".

  ## Examples

      iex> Day1ChronalCalibration.found_duplicate(%{0 => 1, 1 => 2})
      true
  """
  def found_duplicate(map) do
    unique_values = Map.values(map) |> MapSet.new()
    MapSet.member?(unique_values, 2)
  end

  @doc """
  delta = the change being made in this step of the input
  The seen_map contains
     key = a given sum, and
     value = count of times we have seen this sum

  Returns {:halt, {sum, seen_map}} if the same sum has been seen twice.
  Returns {:cont, {sum, seen_map}} otherwise

  ## Examples

      iex> Day1ChronalCalibration.sum_not_reached_twice("+2", {14, %{16 => 1}})
      {:halt, {16, %{16 => 2}}}
  """
  def sum_not_reached_twice(delta, {acc, seen_map}) do
    new_acc = sum(delta, acc)

    if Map.has_key?(seen_map, new_acc) do
      new_seen_map = Map.put(seen_map, new_acc, 2)
      {:halt, {new_acc, new_seen_map}}
    else
      new_seen_map = Map.put(seen_map, new_acc, 1)
      {:cont, {new_acc, new_seen_map}}
    end
  end

  @doc """
  ## Examples

      iex> Day1ChronalCalibration.sum("+2", 5)
      7

      iex> Day1ChronalCalibration.sum("-2", 5)
      3
  """
  def sum("+" <> string_num, acc), do: acc + convert_to_int(string_num)
  def sum("-" <> string_num, acc), do: acc - convert_to_int(string_num)

  defp convert_to_int(string_num) do
    {num, _} = Integer.parse(string_num)
    num
  end
end
