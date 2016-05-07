defmodule Numerix.Statistics do
  @moduledoc """
  Common statistical functions.
  """

  @doc """
  Calculates the average of a list of numbers.
  """
  @spec mean([number]) :: number
  def mean([]), do: 0
  def mean(xs) do
    Enum.sum(xs) / length(xs)
  end

  @doc """
  Returns the middle value in a list of numbers.
  """
  @spec median([number]) :: number
  def median([]), do: 0
  def median(xs) do
    middle_index = round((length(xs) / 2)) - 1
    xs |> Enum.sort |> Enum.at(middle_index)
  end

  @doc """
  Calculates the most frequent value(s) in a list.
  """
  @spec mode([number]) :: [number] | nil
  def mode([]), do: nil
  def mode(xs) do
    counts = xs |> Enum.reduce(%{}, fn(x, acc) ->
      acc |> Map.update(x, 1, fn count -> count + 1 end)
    end)

    {_, max_count} = counts |> Enum.max_by(fn {_x, count} -> count end)

    case max_count do
      1 -> nil
      _ -> counts
           |> Enum.filter_map(fn {_x, count} -> count == max_count end,
                              fn {x, _count} -> x end)
    end
  end

  @doc """
  Calculates the difference between the largest and smallest values in a list.
  """
  @spec range([number]) :: number
  def range([]), do: 0
  def range(xs) do
    {minimum, maximum} = Enum.min_max(xs)
    maximum - minimum
  end

end