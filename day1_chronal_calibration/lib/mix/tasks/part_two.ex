defmodule Mix.Tasks.PartTwo do
  use Mix.Task

  # The @shortdoc allows 'mix help' to show our application.
  @shortdoc "Find the first frequency that is reached twice"
  def run(_) do
    Day1ChronalCalibration.part_two("input.txt") |> IO.inspect()
  end
end
