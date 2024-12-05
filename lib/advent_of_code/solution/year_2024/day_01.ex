defmodule AdventOfCode.Solution.Year2024.Day01 do
  defp input_to_lists(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [x, y] -> {String.to_integer(x), String.to_integer(y)} end)
    |> Enum.unzip()
  end

  defp calculate_distances_lists(left_list, right_list) do
    Enum.zip(left_list, right_list)
    |> Enum.reduce(0, fn {x, y}, acc -> acc + abs(y - x) end)
  end

  defp similarity_score(number, list) do
    count = Enum.count(list, fn x -> number == x end)
    number * count
  end

  def part1(input) do
    {left_list, right_list} = input_to_lists(input)
    calculate_distances_lists(Enum.sort(left_list), Enum.sort(right_list))
  end

  def part2(input) do
    {left_list, right_list} = input_to_lists(input)

    left_list
    |> Enum.map(&similarity_score(&1, right_list))
    |> Enum.sum()
  end
end
