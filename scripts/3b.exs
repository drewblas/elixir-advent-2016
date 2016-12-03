defmodule ThreeB do
  def go do
    IO.read(:stdio, :all)
    |> String.strip
    |> String.split("\n", trim: true)
    |> Enum.map(&line_to_nums/1)
    |> Enum.chunk(3)
    |> Enum.flat_map(&transpose/1)
    |> Enum.map(&is_triangle/1)
    |> Enum.count(&(&1)) # Count only True values
  end

  # Takes "5 10 25" and turns it into [5, 10, 25]
  def line_to_nums(line) do
    line |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1)
  end

  def is_triangle([a,b,c]) when a+b>c and b+c>a and c+a>b, do: true
  def is_triangle([_a,_b,_c]), do: false

  def transpose([[]|_]), do: []
  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end

end

IO.puts ThreeB.go
