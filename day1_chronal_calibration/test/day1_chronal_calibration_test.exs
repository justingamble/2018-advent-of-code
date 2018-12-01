defmodule Day1ChronalCalibrationTest do
  use ExUnit.Case
  doctest Day1ChronalCalibration

  test "+1, +1, +1 results in 3" do
    result =
      ["+1", "+1", "+1"]
      |> Enum.reduce(0, &Day1ChronalCalibration.sum/2)

    assert(result == 3)
  end

  test "+1, +1, -2 results in 0" do
    result =
      ["+1", "+1", "-2"]
      |> Enum.reduce(0, &Day1ChronalCalibration.sum/2)

    assert(result == 0)
  end

  test "-1, -2, -3 results in -6" do
    result =
      ["-1", "-2", "-3"]
      |> Enum.reduce(0, &Day1ChronalCalibration.sum/2)

    assert(result == -6)
  end
end
