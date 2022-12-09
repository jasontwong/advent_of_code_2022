defmodule Advent.Day8 do
  def answer_p1 do
    matrix = make_matrix(get_data())
    rows = length(matrix)

    cols =
      matrix
      |> List.first()
      |> length()

    filter_trees(:visibility, matrix, {rows, cols})
  end

  def answer_p2 do
    matrix = make_matrix(get_data())
    rows = length(matrix)

    cols =
      matrix
      |> List.first()
      |> length()

    filter_trees(:score, matrix, {rows, cols})
  end

  def filter_trees(type, matrix, stop, coordinate \\ {0, 0}, acc \\ 0)

  def filter_trees(_type, _matrix, {rows, cols}, {x, y}, acc)
      when x == rows and y == cols do
    acc
  end

  def filter_trees(:score, matrix, stop, coordinate, acc) do
    next = next_coordinate(coordinate, stop)
    score = get_scenic_score(matrix, coordinate)

    case score > acc do
      true -> filter_trees(:score, matrix, stop, next, score)
      false -> filter_trees(:score, matrix, stop, next, acc)
    end
  end

  def filter_trees(:visibility, matrix, stop, coordinate, acc) do
    next = next_coordinate(coordinate, stop)

    case get_tree_visibility(matrix, coordinate) do
      true -> filter_trees(:visibility, matrix, stop, next, acc + 1)
      false -> filter_trees(:visibility, matrix, stop, next, acc)
    end
  end

  def get_tree_visibility(_matrix, {x, y}) when x == 0 or y == 0, do: true

  def get_tree_visibility(matrix, {x, y}) do
    row = Enum.at(matrix, y)

    column =
      matrix
      |> Enum.zip()
      |> Enum.at(x)
      |> Tuple.to_list()

    tree = find_tree_value(matrix, {x, y})
    can_see?(row, x, tree) or can_see?(column, y, tree)
  end

  def can_see?(group, index, _tree) when length(group) - 1 == index, do: true

  def can_see?(group, index, tree) do
    first_block =
      group
      |> Enum.slice(0..(index - 1))
      |> Enum.find(&(&1 >= tree))

    second_block =
      group
      |> Enum.slice((index + 1)..-1)
      |> Enum.find(&(&1 >= tree))

    is_nil(first_block) or is_nil(second_block)
  end

  def get_scenic_score(matrix, {x, y}) do
    tree = find_tree_value(matrix, {x, y})

    row =
      matrix
      |> Enum.at(y)
      |> get_num_trees(x, tree)

    column =
      matrix
      |> Enum.zip()
      |> Enum.at(x)
      |> Tuple.to_list()
      |> get_num_trees(y, tree)

    row
    |> Kernel.++(column)
    |> Enum.reduce(1, &Kernel.*(&1, &2))
  end

  def get_num_trees(group, index, _tree) when index == length(group) - 1, do: [0, 0]
  def get_num_trees(_group, index, _tree) when index == 0, do: [0, 0]

  def get_num_trees(group, index, tree) do
    first =
      group
      |> Enum.slice(0..(index - 1))
      |> Enum.reverse()
      |> calculate_num_trees(tree)

    second =
      group
      |> Enum.slice((index + 1)..-1)
      |> calculate_num_trees(tree)

    [first, second]
  end

  def calculate_num_trees(group, tree) do
    group
    |> Enum.find_index(&(&1 >= tree))
    |> case do
      nil -> length(group)
      num -> num + 1
    end
  end

  def find_tree_value(_matrix, {x, y}) when x < 0 or y < 0, do: nil

  def find_tree_value(matrix, {x, y}) do
    matrix
    |> Enum.at(y)
    |> case do
      nil -> nil
      row -> Enum.at(row, x)
    end
  end

  def next_coordinate({x, y}, {rows, cols}) when x >= rows - 1 and y >= cols - 1 do
    {cols, rows}
  end

  def next_coordinate({x, y}, {_rows, cols}) when x >= cols - 1 do
    {0, y + 1}
  end

  def next_coordinate({x, y}, {rows, _cols}) when y >= rows - 1 do
    {x + 1, y}
  end

  def next_coordinate({x, y}, _stop) do
    {x + 1, y}
  end

  defp get_data() do
    {:ok, data} =
      :advent
      |> :code.priv_dir()
      |> Path.join("day8_input.txt")
      |> File.read()

    data
  end

  def make_matrix(data) do
    data
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn row ->
      row
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end
