defmodule Advent.Day7Test do
  use ExUnit.Case

  @input """
    $ cd /
    $ ls
    dir a
    14848514 b.txt
    8504156 c.dat
    dir d
    $ cd a
    $ ls
    dir e
    29116 f
    2557 g
    62596 h.lst
    $ cd e
    $ ls
    584 i
    $ cd ..
    $ cd ..
    $ cd d
    $ ls
    4060174 j
    8033020 d.log
    5626152 d.ext
    7214296 k
  """

  # - / (dir)
  # - a (dir)
  #   - e (dir)
  #     - i (file, size=584)
  #   - f (file, size=29116)
  #   - g (file, size=2557)
  #   - h.lst (file, size=62596)
  # - b.txt (file, size=14848514)
  # - c.dat (file, size=8504156)
  # - d (dir)
  #   - j (file, size=4060174)
  #   - d.log (file, size=8033020)
  #   - d.ext (file, size=5626152)
  #   - k (file, size=7214296)

  describe "get_dir_sizes" do
    setup do
      hierarchy =
        @input
        |> String.trim()
        |> String.split("\n", trim: true)
        |> Advent.Day7.make_hierarchy()

      %{hierarchy: hierarchy}
    end

    test "all", %{hierarchy: hierarchy} do
      sizes = Advent.Day7.get_dir_sizes(hierarchy)

      assert sizes == %{
               "/" => 48_381_165,
               "/a" => 94853,
               "/a/e" => 584,
               "/d" => 24_933_642
             }
    end

    test "limit 100000", %{hierarchy: hierarchy} do
      sizes = Advent.Day7.get_dir_sizes(hierarchy, 100_000)

      assert sizes == %{
               "/a" => 94853,
               "/a/e" => 584
             }

      assert Enum.reduce(sizes, 0, fn {_dir, size}, acc -> acc + size end) == 95437
    end
  end

  test "make_hierarchy" do
    hierarchy =
      @input
      |> String.trim()
      |> String.split("\n", trim: true)
      |> Advent.Day7.make_hierarchy()

    assert hierarchy == %{
             "/" => [8_504_156, 14_848_514],
             "/a" => [62596, 2557, 29116],
             "/a/e" => [584],
             "/d" => [7_214_296, 5_626_152, 8_033_020, 4_060_174]
           }
  end
end
