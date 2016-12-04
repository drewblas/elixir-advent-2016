defmodule FourA do
  def go do
    IO.read(:stdio, :all)
    |> String.strip
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.map(&sector_id_of/1)
    |> Enum.sum
  end

  def parse(line) do
    [_whole, letters, id, checksum] = ~r/([a-z\-]+)([0-9]+)\[([a-z]+)\]/ |> Regex.run(line)
    {String.replace(letters, "-", ""), String.to_integer(id), checksum}
  end

  def sector_id_of({letters, id, cs}) do
    if cs == checksum(letters) do
      id
    else
      0
    end
  end

  def checksum(letters) do
    letters
    |> String.split("", trim: true)
    |> Enum.reduce(%{}, &add_to_map_count/2)
    |> Enum.into([]) # A keyword list uses tuples, which can be sorted
    |> Enum.map(&swap_tuple/1) # Now the number is first, then the letter
    |> Enum.sort # Now sorted by number first, then alphabetical
    |> Enum.take(5)
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.join
  end

  # Sneaky - use negative ints because when we sort we want
  # high nums first, but want letters to remain alphabetical
  def swap_tuple({a,b}), do: {-b,a}

  def add_to_map_count(char, map) do
    # Nested captures aren't allowed, so had to break this helper out
    Map.update(map, char, 1, &(&1 + 1))
  end
end

IO.puts FourA.go
