defmodule Advent.Day5 do
  def answer_p1, do: use_cratemover()

  def answer_p2, do: use_cratemover(true)

  defp get_data() do
    {:ok, data} =
      :advent
      |> :code.priv_dir()
      |> Path.join("day5_input.txt")
      |> File.read()

    [stacks, instructions] =
      data
      |> String.trim()
      |> String.split("\n\n")

    {make_stacks(stacks), make_instructions(instructions)}
  end

  defp make_instructions(data) do
    data
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(~r{[^\d]+}, trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp make_stacks(data) do
    [id_stack | split_stack] =
      data
      |> String.split("\n")
      |> Enum.reverse()

    num_stacks =
      id_stack
      |> String.trim()
      |> String.split(" ")
      |> List.last()
      |> String.to_integer()

    []
    |> List.duplicate(num_stacks)
    |> Enum.with_index()
    |> Enum.map(fn {column, index} ->
      split_stack
      |> Enum.map(fn row ->
        case String.at(row, index * 4 + 1) do
          nil -> nil
          " " -> nil
          l -> [l | column]
        end
      end)
      |> Enum.filter(&is_list/1)
    end)
  end

  defp move_cargo(from, to, 0, _), do: {from, to}

  defp move_cargo([hd | from], to, num, false) do
    move_cargo(from, [hd | to], num - 1, false)
  end

  defp move_cargo(from, to, num, true) do
    cargo = Enum.slice(from, 0..(num - 1))

    from
    |> Enum.slice(num..-1)
    |> move_cargo(cargo ++ to, 0, true)
  end

  defp use_cratemover(bulk \\ false) do
    {stacks, instructions} = get_data()

    instructions
    |> Enum.reduce(stacks |> IO.inspect(), fn [num, from, to], acc ->
      from_idx = from - 1
      to_idx = to - 1

      from_stack =
        acc
        |> Enum.at(from_idx)
        |> Enum.reverse()

      to_stack =
        acc
        |> Enum.at(to_idx)
        |> Enum.reverse()

      {from_stack, to_stack} = move_cargo(from_stack, to_stack, num, bulk)

      acc
      |> List.replace_at(from_idx, Enum.reverse(from_stack))
      |> List.replace_at(to_idx, Enum.reverse(to_stack))
    end)
    |> Enum.map(&List.last/1)
    |> List.flatten()
    |> Enum.join()
  end
end
