defmodule Advent.Day9 do
  def play do
  end

  def answer_p1 do
    get_data()
    |> make_instructions()
    |> process_instructions()
    |> Enum.uniq()
    |> Enum.count()
  end

  def answer_p2 do
  end

  def make_instructions(data) do
    data
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn row ->
      [dir, num] = String.split(row, " ", trim: true)
      [dir, String.to_integer(num)]
    end)
  end

  def next_move(move, head, tail, acc \\ [])
  def next_move([_dir, 0], head, tail, acc), do: {head, tail, acc}

  def next_move([dir, num], tail, tail, acc) do
    head = move_head(dir, tail)
    next_move([dir, num - 1], head, tail, acc)
  end

  def next_move([dir, num], head, tail, acc) do
    head = move_head(dir, head)
    new_tail = move_tail(head, tail)

    case tail == new_tail do
      true -> next_move([dir, num - 1], head, tail, acc)
      false -> next_move([dir, num - 1], head, new_tail, [new_tail | acc])
    end
  end

  # left
  def move_tail({head_x, head_y}, {tail_x, tail_y})
      when head_x - tail_x < -1 and head_y == tail_y do
    {tail_x - 1, tail_y}
  end

  # right
  def move_tail({head_x, head_y}, {tail_x, tail_y})
      when head_x - tail_x > 1 and head_y == tail_y do
    {tail_x + 1, tail_y}
  end

  # up
  def move_tail({head_x, head_y}, {tail_x, tail_y})
      when head_y - tail_y > 1 and head_x == tail_x do
    {tail_x, tail_y + 1}
  end

  # down
  def move_tail({head_x, head_y}, {tail_x, tail_y})
      when head_y - tail_y < -1 and head_x == tail_x do
    {tail_x, tail_y - 1}
  end

  def move_tail({head_x, head_y}, {tail_x, tail_y} = tail) do
    y_diff = head_y - tail_y
    x_diff = head_x - tail_x

    cond do
      # up right
      (y_diff >= 1 and x_diff > 1) or (y_diff > 1 and x_diff >= 1) ->
        {tail_x + 1, tail_y + 1}

      # up left
      (y_diff >= 1 and x_diff < -1) or (y_diff > 1 and x_diff <= -1) ->
        {tail_x - 1, tail_y + 1}

      # down right
      (y_diff < -1 and x_diff >= 1) or (y_diff <= -1 and x_diff > 1) ->
        {tail_x + 1, tail_y - 1}

      # down left
      (y_diff <= -1 and x_diff < -1) or (y_diff < -1 and x_diff <= -1) ->
        {tail_x - 1, tail_y - 1}

      true ->
        tail
    end
  end

  def move_head("R", {x, y}), do: {x + 1, y}
  def move_head("L", {x, y}), do: {x - 1, y}
  def move_head("U", {x, y}), do: {x, y + 1}
  def move_head("D", {x, y}), do: {x, y - 1}

  def process_instructions(instructions, head \\ {0, 0}, tail \\ {0, 0}, acc \\ [{0, 0}])
  def process_instructions([], _head, _tail, acc), do: acc

  def process_instructions([hd | instructions], head, tail, acc) do
    {head, tail, movements} = next_move(hd, head, tail)
    process_instructions(instructions, head, tail, movements ++ acc)
  end

  defp get_data() do
    {:ok, data} =
      :advent
      |> :code.priv_dir()
      |> Path.join("day9_input.txt")
      |> File.read()

    data
  end
end
