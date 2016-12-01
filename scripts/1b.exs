defmodule OneB do
  def go do
    IO.read(:stdio, :all)
    |> String.strip
    |> String.split(", ")
    |> IO.inspect
    |> Enum.map(&str_to_tuple/1)
    |> visit("N", {0,0}, MapSet.new([{0,0}]))
    |> distance_of
  end

  # Converts str like "R4" to {"R", 4}
  def str_to_tuple(str) do
    {dir,num} = str |> String.split_at(1)
    {dir,String.to_integer(num)}
  end

  def distance_of({x,y}), do: abs(x) + abs(y)

  def visit([], _face, pos, _visited), do: pos

  def visit([{"R",num} | rest], "N", pos, visited), do: rest |> step(num, "E", pos, visited)
  def visit([{"L",num} | rest], "N", pos, visited), do: rest |> step(num, "W", pos, visited)

  def visit([{"R",num} | rest], "S", pos, visited), do: rest |> step(num, "W", pos, visited)
  def visit([{"L",num} | rest], "S", pos, visited), do: rest |> step(num, "E", pos, visited)

  def visit([{"R",num} | rest], "E", pos, visited), do: rest |> step(num, "S", pos, visited)
  def visit([{"L",num} | rest], "E", pos, visited), do: rest |> step(num, "N", pos, visited)

  def visit([{"R",num} | rest], "W", pos, visited), do: rest |> step(num, "N", pos, visited)
  def visit([{"L",num} | rest], "W", pos, visited), do: rest |> step(num, "S", pos, visited)

  def step(list, 0, dir, pos, visited), do: visit(list, dir, pos, visited)

  def step(list, steps, "E"=dir, {x,y}, visited), do: check(list, steps, dir, {x+1,y}, visited)
  def step(list, steps, "W"=dir, {x,y}, visited), do: check(list, steps, dir, {x-1,y}, visited)
  def step(list, steps, "N"=dir, {x,y}, visited), do: check(list, steps, dir, {x,y-1}, visited)
  def step(list, steps, "S"=dir, {x,y}, visited), do: check(list, steps, dir, {x,y+1}, visited)

  def check(list, steps, dir, {x,y}=pos, visited) do
    if MapSet.member?(visited, pos) do
      pos
    else
      step(list, steps - 1, dir, pos, MapSet.put(visited, pos))
    end
  end


end

IO.puts OneB.go
