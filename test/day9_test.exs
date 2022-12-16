defmodule Advent.Day9Test do
  use ExUnit.Case

  alias Advent.Day9

  @input """
  R 4
  U 4
  L 3
  D 1
  R 4
  D 1
  L 5
  R 2
  """

  describe "answer_p1" do
    setup do
      moves =
        @input
        |> Day9.make_instructions()
        |> Day9.process_instructions()

      %{moves: moves}
    end

    test "next_move" do
      assert Day9.next_move(["R", 4], {0, 0}, {0, 0}, []) ==
               {{4, 0}, {3, 0}, [{3, 0}, {2, 0}, {1, 0}]}

      assert Day9.next_move(["U", 4], {4, 0}, {3, 0}, []) ==
               {{4, 4}, {4, 3}, [{4, 3}, {4, 2}, {4, 1}]}

      assert Day9.next_move(["L", 3], {4, 4}, {4, 3}, []) == {{1, 4}, {2, 4}, [{2, 4}, {3, 4}]}
      assert Day9.next_move(["D", 1], {1, 4}, {2, 4}, []) == {{1, 3}, {2, 4}, []}
      assert Day9.next_move(["R", 4], {1, 3}, {2, 4}, []) == {{5, 3}, {4, 3}, [{4, 3}, {3, 3}]}
      assert Day9.next_move(["D", 1], {5, 3}, {4, 3}, []) == {{5, 2}, {4, 3}, []}

      assert Day9.next_move(["L", 5], {5, 2}, {4, 3}, []) ==
               {{0, 2}, {1, 2}, [{1, 2}, {2, 2}, {3, 2}]}

      assert Day9.next_move(["R", 2], {0, 2}, {1, 2}, []) == {{2, 2}, {1, 2}, []}
    end

    test "process_instructions", %{moves: moves} do
      assert Enum.reverse(moves) ==
               [
                 {0, 0},
                 {1, 0},
                 {2, 0},
                 {3, 0},
                 {4, 1},
                 {4, 2},
                 {4, 3},
                 {3, 4},
                 {2, 4},
                 {3, 3},
                 {4, 3},
                 {3, 2},
                 {2, 2},
                 {1, 2}
               ]
    end

    test "answer_p1", %{moves: moves} do
      num_positions =
        moves
        |> Enum.uniq()
        |> Enum.count()

      assert num_positions == 13
    end
  end
end
