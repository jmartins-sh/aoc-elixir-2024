defmodule AdventOfCode.Solution.Year2024.Day04 do
  defp input_to_grid(input) do
    charlist = input |> String.split() |> Enum.map(&String.to_charlist/1)

    for {row, i} <- Enum.with_index(charlist),
        {char, j} <- Enum.with_index(row),
        into: %{},
        do: {{i, j}, char}
  end

  defp brute_force_sum(directions, grid) do
    directions
    |> Enum.map(fn {di, dj} ->
      Enum.count(Map.keys(grid), fn spot ->
        spot
        |> Stream.iterate(fn {i, j} -> {i + di, j + dj} end)
        |> Stream.take(4)
        |> Enum.map(&grid[&1])
        |> Kernel.==(~c"XMAS")
      end)
    end)
    |> Enum.sum()
  end

  def part1(input) do
    grid = input_to_grid(input) |> dbg()

    IO.inspect(grid[{100, 74}])

    directions =
      for di <- -1..1,
          dj <- -1..1,
          di != 0 or dj != 0,
          do: {di, dj}

    directions
    |> brute_force_sum(grid)
  end

  def part2(input) do
    grid = input_to_grid(input)

    grid
    |> Enum.count(fn
      {{i, j}, ?A} ->
        [grid[{i - 1, j - 1}], grid[{i + 1, j + 1}]] in [~c"MS", ~c"SM"] and
          [grid[{i - 1, j + 1}], grid[{i + 1, j - 1}]] in [~c"MS", ~c"SM"]

      _ ->
        false
    end)
  end
end
