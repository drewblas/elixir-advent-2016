defmodule SixB do
  def go do
    IO.read(:stdio, :all)
    |> String.strip
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true)) # After this it's a matrix
    |> transpose
    |> Enum.map(&most_occur/1)
  end

  def transpose([[]|_]), do: []
  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end
  def swap_tuple({a,b}), do: {b,a}

  def most_occur(list) do
    list
    |> Enum.reduce(%{}, fn(char, map) ->
      Map.update(map, char, 1, fn(amt) -> amt + 1 end)
    end)
    |> Enum.into([])
    |> Enum.map(&swap_tuple/1)
    |> Enum.sort
    |> hd
    |> elem(1)
  end
end

IO.puts SixB.go
