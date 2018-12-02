defmodule Day1ChronalCalibrationPart2Test do
  use ExUnit.Case
  doctest Day1ChronalCalibration

  @default_acc {0, %{0 => 1}}
  @input_file_name "unit_test_input.txt"

  setup do
    on_exit(fn ->
      if File.exists?(@input_file_name) do
        File.rm(@input_file_name)
      end
    end)
  end

  test "sample input: +1, -2, +3, +1, +1, -2 first reaches 2 twice" do
    run_sample_input_test(["+1", "-2", "+3", "+1", "+1", "-2"], 2)
  end

  test "sample input: +1, -1 first reaches 0 twice" do
    run_sample_input_test(["+1", "-1"], 0)
  end

  test "sample input: +3, +3, +4, -2, -4 first reaches 10 twice" do
    run_sample_input_test(["+3", "+3", "+4", "-2", "-4"], 10)
  end

  test "sample input: -6, +3, +8, +5, -6 first reaches 5 twice" do
    run_sample_input_test(["-6", "+3", "+8", "+5", "-6"], 5)
  end

  test "sample input: +7, +7, -2, -7, -4 first reaches 14 twice" do
    run_sample_input_test(["+7", "+7", "-2", "-7", "-4"], 14)
  end

  defp run_sample_input_test(input_list, expected_result) do
    {:ok, file} = File.open(@input_file_name, [:write])
    input_list |> Enum.each(&IO.binwrite(file, &1 <> "\n"))
    File.close(file)

    assert(Day1ChronalCalibration.part_two(@input_file_name) == expected_result)
  end

  test "found_duplicate() identifies when a duplicate is found" do
    made_up_map = %{0 => 1, 1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 2}
    assert(Day1ChronalCalibration.found_duplicate(made_up_map) == true)
  end

  test "found_duplicate() identifies when no duplicate is found" do
    made_up_map = %{0 => 1, 1 => 1, 2 => 1, 3 => 1, 4 => 1, 5 => 1}
    assert(Day1ChronalCalibration.found_duplicate(made_up_map) == false)
  end

  test "sum_not_reached_twice() says that +1, -1 results in 0 twice" do
    expected_sum = 0
    expected_map = %{0 => 2, 1 => 1}
    expected_found_duplicate = true

    run_sum_not_reached_twice_test(
      ["+1", "-1"],
      expected_sum,
      expected_map,
      expected_found_duplicate
    )
  end

  test "sum_not_reached_twice() returns a result of 1 and seen_map shows only a count of 1" do
    expected_sum = 1
    expected_map = %{0 => 1, 1 => 1}
    expected_found_duplicate = false

    run_sum_not_reached_twice_test(
      ["+1"],
      expected_sum,
      expected_map,
      expected_found_duplicate
    )
  end

  test "sum_not_reached_twice() input [-6, +3, +8, +5, -16] says that -6 was reached twice" do
    expected_sum = -6
    expected_map = %{-6 => 2, -3 => 1, 0 => 1, 5 => 1, 10 => 1}
    expected_found_duplicate = true

    run_sum_not_reached_twice_test(
      ["-6", "+3", "+8", "+5", "-16"],
      expected_sum,
      expected_map,
      expected_found_duplicate
    )
  end

  test "sum_not_reached_twice() input [+7, +7, -2, -7, -4, +6] first reaches 7 twice" do
    expected_sum = 7
    expected_map = %{0 => 1, 1 => 1, 5 => 1, 7 => 2, 12 => 1, 14 => 1}
    expected_found_duplicate = true

    run_sum_not_reached_twice_test(
      ["+7", "+7", "-2", "-7", "-4", "+6"],
      expected_sum,
      expected_map,
      expected_found_duplicate
    )
  end

  defp run_sum_not_reached_twice_test(
         input_list,
         expected_sum,
         expected_map,
         expected_found_duplicate
       ) do
    {result, map} =
      input_list
      |> Enum.reduce_while(@default_acc, &Day1ChronalCalibration.sum_not_reached_twice/2)

    assert(result == expected_sum)
    assert(map == expected_map)
    assert(Day1ChronalCalibration.found_duplicate(map) == expected_found_duplicate)
  end
end
