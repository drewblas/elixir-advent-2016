defmodule OneA do
  def go do
    IO.read(:stdio, :all)
    |> String.strip
    |> String.split(", ")
    |> IO.inspect
    |> Enum.map(&str_to_tuple/1)
    |> visit("N", {0,0})
    |> distance_of
  end

  # Converts str like "R4" to {"R", 4}
  def str_to_tuple(str) do
    {dir,num} = str |> String.split_at(1)
    {dir,String.to_integer(num)}
  end

  def distance_of({x,y}), do: abs(x) + abs(y)

  def visit([],_face, pos), do: pos

  def visit([{"R",num} | rest], "N", {x,y}), do: rest |> visit("E", {x+num, y})
  def visit([{"L",num} | rest], "N", {x,y}), do: rest |> visit("W", {x-num, y})

  def visit([{"R",num} | rest], "S", {x,y}), do: rest |> visit("W", {x-num, y})
  def visit([{"L",num} | rest], "S", {x,y}), do: rest |> visit("E", {x+num, y})

  def visit([{"R",num} | rest], "E", {x,y}), do: rest |> visit("S", {x, y-num})
  def visit([{"L",num} | rest], "E", {x,y}), do: rest |> visit("N", {x, y+num})

  def visit([{"R",num} | rest], "W", {x,y}), do: rest |> visit("N", {x, y+num})
  def visit([{"L",num} | rest], "W", {x,y}), do: rest |> visit("S", {x, y-num})


end

IO.puts OneA.go
