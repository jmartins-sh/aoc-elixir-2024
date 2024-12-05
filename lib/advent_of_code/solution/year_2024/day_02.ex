defmodule AdventOfCode.Solution.Year2024.Day02 do
  defp input_to_list_of_lists(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)
  end

  defp safe?(list), do: keep_order_level?(list) and adjacent_diff_valid?(list)

  defp keep_order_level?(list) do
    cond do
      length(list) <= 1 -> true
      Enum.all?(Enum.zip(list, Enum.drop(list, 1)), fn {x, y} -> x <= y end) -> true
      Enum.all?(Enum.zip(list, Enum.drop(list, 1)), fn {x, y} -> x >= y end) -> true
      true -> false
    end
  end

  def adjacent_diff_valid?(list) do
    list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.all?(fn [x, y] ->
      diff = abs(x - y)
      diff >= 1 and diff <= 3
    end)
  end

  defp remove_one(list) do
    for {_, index} <- Enum.with_index(list) do
      List.delete_at(list, index)
    end
  end

  defp dampener_problem(list), do: safe?(list) or Enum.any?(remove_one(list), &safe?/1)

  def part1(input) do
    lists = input_to_list_of_lists(input)

    lists
    |> Enum.map(&safe?/1)
    |> Enum.count(fn x -> x == true end)
  end

  def part2(input) do
    lists = input_to_list_of_lists(input)

    lists
    |> Enum.map(&dampener_problem/1)
    |> Enum.count(fn x -> x == true end)
  end
end
