defmodule Mix.Tasks.Tabulate do
  use Mix.Task

  # The @shortdoc allows 'mix help' to show our application.
  @shortdoc "Add/Subtract all the numbers in the input file"
  def run(_) do
    Day1ChronalCalibration.tabulate("input.txt") |> IO.inspect()
  end
end
