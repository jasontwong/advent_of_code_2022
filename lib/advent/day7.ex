defmodule Advent.Day7 do
  def answer_p1 do
    get_data()
    |> make_hierarchy()
    |> get_dir_sizes(100_000)
    |> Enum.reduce(0, fn {_dir, size}, acc -> acc + size end)
  end

  def answer_p2 do
    total_disk_space = 70_000_000
    necessary_free_space = 30_000_000

    dir_sizes =
      get_data()
      |> make_hierarchy()
      |> get_dir_sizes()

    current_free_space = total_disk_space - dir_sizes["/"]

    dir_sizes
    |> Enum.sort_by(fn {_dir, size} -> size end)
    |> Enum.find(fn {_dir, size} ->
      size + current_free_space >= necessary_free_space
    end)
  end

  defp get_data() do
    {:ok, data} =
      :advent
      |> :code.priv_dir()
      |> Path.join("day7_input.txt")
      |> File.read()

    data
    |> String.trim()
    |> String.split("\n")
  end

  def get_dir_sizes(hierarchy, limit \\ nil) do
    hierarchy
    |> Enum.reduce(%{}, fn {dir, sizes}, acc ->
      total_size = Enum.sum(sizes)
      compute_sizes(dir, acc, total_size)
    end)
    |> Enum.filter(fn {_dir, size} ->
      case limit do
        nil -> true
        max_size -> size <= max_size
      end
    end)
    |> Enum.into(%{})
  end

  defp compute_sizes("", acc, size) do
    Map.update(acc, "/", size, fn s -> s + size end)
  end

  defp compute_sizes("/", acc, size), do: compute_sizes("", acc, size)

  defp compute_sizes(dir, acc, size) do
    acc = Map.update(acc, dir, size, fn s -> s + size end)

    dir
    |> String.split("/")
    |> Enum.slice(0..-2)
    |> Enum.join("/")
    |> compute_sizes(acc, size)
  end

  def make_hierarchy(data) do
    {hierarchy, _pwd} =
      data
      |> Enum.reduce({%{}, ""}, fn line, {data, pwd} ->
        line
        |> String.trim()
        |> process_line(data, pwd)
      end)

    hierarchy
  end

  defp process_line("$ cd /", data, _pwd) do
    {Map.put_new(data, "/", []), "/"}
  end

  defp process_line("$ cd ..", data, pwd) do
    pwd =
      pwd
      |> String.split("/")
      |> Enum.slice(0..-2)
      |> Enum.join("/")

    {data, pwd}
  end

  defp process_line("$ cd " <> dir, data, pwd) do
    pwd =
      case pwd == "/" do
        false -> pwd <> "/" <> dir
        true -> pwd <> dir
      end

    {Map.put_new(data, pwd, []), pwd}
  end

  defp process_line("dir" <> _rest, data, pwd), do: {data, pwd}
  defp process_line("$ ls", data, pwd), do: {data, pwd}

  defp process_line(line, data, pwd) do
    new_data =
      Map.update!(data, pwd, fn sizes ->
        size =
          line
          |> String.split(" ", trim: true)
          |> List.first()
          |> String.to_integer()

        [size | sizes]
      end)

    {new_data, pwd}
  end
end
