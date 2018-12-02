defmodule Mix.Tasks.PartTwo do
  use Mix.Task

  # The @shortdoc allows 'mix help' to show our application.
  @shortdoc "Find the two most similar strings, and return the common characters"
  def run(_) do
    Day2InventoryManagementSystemPart2.main("input.txt")
  end
end
