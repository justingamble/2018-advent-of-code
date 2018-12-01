defmodule Day1ChronalCalibration do
  @moduledoc """
  We are not doing error checking on the input file.  We just assume each
  line starts with +/- and is followed by an integer and newline.
  """

  @initial_value 0

  def tabulate(input_file) do
    File.stream!(input_file)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.reduce(@initial_value, &sum/2)
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
