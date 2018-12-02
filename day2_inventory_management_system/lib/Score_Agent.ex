defmodule ScoreAgent do
  @moduledoc """
  Store/retrieve the high score we have collected.

  This class's state: a Score struct.
  """

  @agent_name __MODULE__

  def start_link do
    Agent.start_link(fn -> %Score{} end, name: @agent_name)
  end

  def get_score() do
    Agent.get(@agent_name, fn struct -> struct.score end)
  end

  def get_strings() do
    Agent.get(@agent_name, fn struct -> {struct.string1, struct.string2} end)
  end

  def set_score(new_score, string1, string2) do
    Agent.update(@agent_name, fn struct ->
      %{struct | score: new_score, string1: string1, string2: string2}
    end)
  end

  def debug_print_state() do
    struct = Agent.get(@agent_name, fn x -> x end)
    "score: #{struct.score}, string1: #{struct.string1}, string2: #{struct.string2}"
  end
end
