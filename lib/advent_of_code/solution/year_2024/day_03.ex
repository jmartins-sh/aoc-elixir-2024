defmodule AdventOfCode.Solution.Year2024.Day03 do
  def parse(string) do
    pattern = ~r/mul\(\d+,\d+\)|do\(\)|don't\(\)/
    Regex.scan(pattern, string) |> List.flatten()
  end

  def remove_donts(list) do
    list
    |> Enum.reduce({[], true}, fn
      "do()", {acc, _} ->
        {acc, true}

      "don't()", {acc, _} ->
        {acc, false}

      mul, {acc, true} ->
        {[mul | acc], true}

      _other, acc ->
        acc
    end)
    |> elem(0)
  end

  def multiply_all(list) do
    list
    |> Enum.map(&calculate/1)
    |> Enum.sum()
  end

  defp calculate(statement) do
    pattern = ~r/mul\((\d{1,3}),(\d{1,3})\)/

    pattern
    |> Regex.scan(statement)
    |> Enum.map(fn [_, x, y] -> String.to_integer(x) * String.to_integer(y) end)
    |> Enum.sum()
  end

  def part1(input) do
    input
    |> calculate()
  end

  def part2(input) do
    input
    |> parse()
    |> remove_donts()
    |> multiply_all()
  end
end
