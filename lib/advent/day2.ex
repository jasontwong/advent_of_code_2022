defmodule Advent.Day2 do
  def answer_p1 do
    Enum.reduce(get_pairs(), 0, fn pair, acc ->
      acc + response_points(pair)
    end)
  end

  def answer_p2 do
    Enum.reduce(get_pairs(), 0, fn pair, acc ->
      acc + success_points(pair)
    end)
  end

  defp get_pairs do
    {:ok, data} =
      :advent
      |> :code.priv_dir()
      |> Path.join("day2_input.txt")
      |> File.read()

    data
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
  end

  # When X, Y, Z represents Rock, Paper, Scissors
  defp response_points(["A", "X"]), do: 3 + 1
  defp response_points(["A", "Y"]), do: 6 + 2
  defp response_points(["A", "Z"]), do: 0 + 3

  defp response_points(["B", "X"]), do: 0 + 1
  defp response_points(["B", "Y"]), do: 3 + 2
  defp response_points(["B", "Z"]), do: 6 + 3

  defp response_points(["C", "X"]), do: 6 + 1
  defp response_points(["C", "Y"]), do: 0 + 2
  defp response_points(["C", "Z"]), do: 3 + 3

  # When X, Y, Z represents Loss, Draw, Win
  defp success_points(["A", "X"]), do: response_points(["A", "Z"])
  defp success_points(["A", "Y"]), do: response_points(["A", "X"])
  defp success_points(["A", "Z"]), do: response_points(["A", "Y"])

  defp success_points(["B", "X"]), do: response_points(["B", "X"])
  defp success_points(["B", "Y"]), do: response_points(["B", "Y"])
  defp success_points(["B", "Z"]), do: response_points(["B", "Z"])

  defp success_points(["C", "X"]), do: response_points(["C", "Y"])
  defp success_points(["C", "Y"]), do: response_points(["C", "Z"])
  defp success_points(["C", "Z"]), do: response_points(["C", "X"])
end
