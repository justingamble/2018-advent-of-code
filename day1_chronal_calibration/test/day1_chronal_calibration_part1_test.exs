defmodule Day1ChronalCalibrationPart1Test do
  use ExUnit.Case
  doctest Day1ChronalCalibration

  test "+1, +1, +1 results in 3" do
    run_test(["+1", "+1", "+1"], 3)
  end

  test "+1, +1, -2 results in 0" do
    run_test(["+1", "+1", "-2"], 0)
  end

  test "-1, -2, -3 results in -6" do
    run_test(["-1", "-2", "-3"], -6)
  end

  defp run_test(input_list, expected_result) do
    result =
      input_list
      |> Enum.reduce(0, &Day1ChronalCalibration.sum/2)

    assert(result == expected_result)
  end
end
