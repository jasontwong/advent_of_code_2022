defmodule Advent.Day6 do
  def answer_p1 do
    get_start_marker(get_data(), 4)
  end

  def answer_p2 do
    get_start_marker(get_data(), 14)
  end

  defp get_data() do
    {:ok, data} =
      :advent
      |> :code.priv_dir()
      |> Path.join("day6_input.txt")
      |> File.read()

    data
    |> String.trim()
    |> String.codepoints()
  end

  def get_start_marker(message, stop, index \\ 0, marker \\ [])

  def get_start_marker(_message, stop, index, marker) when length(marker) == stop, do: index

  def get_start_marker([hd | message], stop, index, marker) do
    marker =
      marker
      |> Enum.find_index(fn letter -> letter == hd end)
      |> case do
        nil -> marker
        index -> Enum.slice(marker, (index + 1)..-1)
      end
      |> List.insert_at(-1, hd)

    get_start_marker(message, stop, index + 1, marker)
  end
end
