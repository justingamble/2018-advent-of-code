defmodule Mix.Tasks.PartOne do
  use Mix.Task

  # The @shortdoc allows 'mix help' to show our application.
  @shortdoc "Count the # of words with 2 and 3 repeating characters, and multiply the counts"
  def run(_) do
    Day2InventoryManagementSystem.part_one("input.txt") |> IO.inspect()
#    Day2InventoryManagementSystem.part_one("small.txt")
  end
end
