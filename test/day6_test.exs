defmodule Advent.Day6Test do
  use ExUnit.Case

  describe "get_start_marker" do
    test "4 distinct characters" do
      message = String.codepoints("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
      assert Advent.Day6.get_start_marker(message, 4) == 7

      message = String.codepoints("bvwbjplbgvbhsrlpgdmjqwftvncz")
      assert Advent.Day6.get_start_marker(message, 4) == 5

      message = String.codepoints("nppdvjthqldpwncqszvftbrmjlhg")
      assert Advent.Day6.get_start_marker(message, 4) == 6

      message = String.codepoints("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
      assert Advent.Day6.get_start_marker(message, 4) == 10

      message = String.codepoints("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
      assert Advent.Day6.get_start_marker(message, 4) == 11
    end

    test "14 distinct characters" do
      message = String.codepoints("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
      assert Advent.Day6.get_start_marker(message, 14) == 19

      message = String.codepoints("bvwbjplbgvbhsrlpgdmjqwftvncz")
      assert Advent.Day6.get_start_marker(message, 14) == 23

      message = String.codepoints("nppdvjthqldpwncqszvftbrmjlhg")
      assert Advent.Day6.get_start_marker(message, 14) == 23

      message = String.codepoints("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
      assert Advent.Day6.get_start_marker(message, 14) == 29

      message = String.codepoints("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
      assert Advent.Day6.get_start_marker(message, 14) == 26
    end
  end
end
