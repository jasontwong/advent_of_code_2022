defmodule Advent.Day4 do
  def answer_p1 do
    Enum.reduce(get_pairs(), 0, fn pair, acc ->
      [[lower1, upper1], [lower2, upper2]] = maybe_swap_pair(pair)

      with true <- lower1 <= lower2,
           true <- upper1 >= upper2 do
        acc + 1
      else
        _ -> acc
      end
    end)
  end

  def answer_p2 do
    Enum.reduce(get_pairs(), 0, fn pair, acc ->
      [r1, r2] = Enum.map(pair, &make_range/1)

      case Range.disjoint?(r1, r2) do
        true -> acc
        false -> acc + 1
      end
    end)
  end

  defp get_pairs() do
    {:ok, data} =
      :advent
      |> :code.priv_dir()
      |> Path.join("day4_input.txt")
      |> File.read()

    data
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&make_pairs/1)
  end

  defp make_integers(sections) do
    sections
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
  end

  defp make_pairs(data) do
    data
    |> String.split(",")
    |> Enum.map(&make_integers/1)
  end

  defp make_range([start, stop]) do
    Range.new(start, stop)
  end

  defp maybe_swap_pair([[lower1, upper1] = first, [lower2, upper2] = second]) do
    case lower2 < lower1 or upper2 > upper1 do
      true -> [second, first]
      false -> [first, second]
    end
  end
end
