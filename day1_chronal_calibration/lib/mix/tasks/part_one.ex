defmodule Mix.Tasks.PartOne do
  use Mix.Task

  # The @shortdoc allows 'mix help' to show our application.
  @shortdoc "Add/Subtract all the numbers in the input file"
  def run(_) do
    Day1ChronalCalibration.part_one("input.txt") |> IO.inspect()
  end
end
