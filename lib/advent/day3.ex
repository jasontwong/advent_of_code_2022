defmodule Advent.Day3 do
  def answer_p1 do
    calculate_points(get_compartments())
  end

  def answer_p2 do
    get_rucksacks()
    |> Enum.chunk_every(3)
    |> calculate_points()
  end

  defp calculate_points(rucksacks) do
    Enum.reduce(rucksacks, 0, fn rucksack, acc ->
      rucksack
      |> find_duplicate()
      |> get_priority()
      |> Kernel.+(acc)
    end)
  end

  defp find_duplicate([first | others]), do: find_duplicate(others, first, others)

  defp find_duplicate([next | []], [search | rest], others) do
    case search in next do
      true -> search
      false -> find_duplicate(others, rest, others)
    end
  end

  defp find_duplicate([next | leftovers], [search | rest] = first, others) do
    case search in next do
      true -> find_duplicate(leftovers, first, others)
      false -> find_duplicate(others, rest, others)
    end
  end

  defp get_compartments do
    Enum.map(get_rucksacks(), fn item ->
      len = length(item)
      half_len = div(len, 2)
      Enum.chunk_every(item, half_len)
    end)
  end

  defp get_priority(char) when char in ?a..?z, do: char - ?a + 1
  defp get_priority(char) when char in ?A..?Z, do: char - ?A + 27

  defp get_rucksacks do
    {:ok, data} =
      :advent
      |> :code.priv_dir()
      |> Path.join("day3_input.txt")
      |> File.read()

    data
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_charlist/1)
  end
end
