defmodule Mix.Tasks.PartOne do
  use Mix.Task

  # The @shortdoc allows 'mix help' to show our application.
  @shortdoc "Count the # of words with 2 and 3 repeating characters, and multiply the counts"
  def run(_) do
    Day2InventoryManagementSystemPart1.main("input.txt") |> IO.inspect()
  end
end
