defmodule Advent.Day1 do
  def answer_p1 do
    Enum.max(get_calories())
  end

  def answer_p2 do
    get_calories()
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.slice(0..2)
    |> Enum.sum()
  end

  defp get_calories() do
    {:ok, data} =
      :advent
      |> :code.priv_dir()
      |> Path.join("day1_input.txt")
      |> File.read()

    data
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&sum_calories/1)
  end

  defp sum_calories(elf) do
    elf
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end
