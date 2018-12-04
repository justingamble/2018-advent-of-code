defmodule Day3 do

    def overlapped_squares(string) do
    end

end


case System.argv() do
  ["--test"] -> 
    ExUnit.start()

    defmodule Day3Test do
       use ExUnit.Case

       import Day3

       test "a" do
	   assert overlapped_squares("""
	   a
	   b
	   """) == 2
       end
    end
  [input_file] -> 
    input_file
    |> File.read!() 
    |> Day3.overlapped_squares()
    |> IO.puts()

  _ -> IO.puts :stderr, "we expected --test or an input file"
end
