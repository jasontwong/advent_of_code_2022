defmodule Advent.Day8Test do
  use ExUnit.Case

  alias Advent.Day8

  @input """
  30373
  25512
  65332
  33549
  35390
  """

  describe "filter_trees" do
    test "visibility" do
      matrix = Day8.make_matrix(@input)
      rows = length(matrix)

      cols =
        matrix
        |> List.first()
        |> length()

      assert Day8.filter_trees(:visibility, matrix, {rows, cols}) == 21
    end
  end

  test "get_best_scene" do
    matrix = Day8.make_matrix(@input)
    rows = length(matrix)

    cols =
      matrix
      |> List.first()
      |> length()

    assert Day8.filter_trees(:score, matrix, {rows, cols}) == 8
  end

  test "get_scenic_score" do
    matrix = Day8.make_matrix(@input)
    assert Day8.get_scenic_score(matrix, {2, 1}) == 4
    assert Day8.get_scenic_score(matrix, {0, 2}) == 0
  end

  test "make_matrix" do
    assert Day8.make_matrix(@input) == [
             [3, 0, 3, 7, 3],
             [2, 5, 5, 1, 2],
             [6, 5, 3, 3, 2],
             [3, 3, 5, 4, 9],
             [3, 5, 3, 9, 0]
           ]
  end

  test "next_coordinate" do
    matrix = Day8.make_matrix(@input)
    rows = length(matrix)

    cols =
      matrix
      |> List.first()
      |> length()

    assert Day8.next_coordinate({1, 0}, {rows, cols}) == {2, 0}
    assert Day8.next_coordinate({4, 0}, {rows, cols}) == {0, 1}
    assert Day8.next_coordinate({0, 4}, {rows, cols}) == {1, 4}
    assert Day8.next_coordinate({4, 4}, {rows, cols}) == {cols, rows}
  end

  test "find_tree_value" do
    matrix = Day8.make_matrix(@input)

    assert Day8.find_tree_value(matrix, {0, 0}) == 3
    assert Day8.find_tree_value(matrix, {3, 0}) == 7
    assert Day8.find_tree_value(matrix, {3, 3}) == 4
    assert Day8.find_tree_value(matrix, {1, 2}) == 5
    assert Day8.find_tree_value(matrix, {4, 3}) == 9

    assert Day8.find_tree_value(matrix, {8, 3}) == nil
    assert Day8.find_tree_value(matrix, {-1, 2}) == nil
    assert Day8.find_tree_value(matrix, {1, 20}) == nil
    assert Day8.find_tree_value(matrix, {3, -4}) == nil
  end
end
