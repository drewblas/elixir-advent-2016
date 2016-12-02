defmodule TwoB do
  @move %{
    {"U", 1} => 1,
    {"D", 1} => 3,
    {"L", 1} => 1,
    {"R", 1} => 1,

    {"U", 2} => 2,
    {"D", 2} => 6,
    {"L", 2} => 2,
    {"R", 2} => 3,

    {"U", 3} => 1,
    {"D", 3} => 7,
    {"L", 3} => 2,
    {"R", 3} => 4,

    {"U", 4} => 4,
    {"D", 4} => 8,
    {"L", 4} => 3,
    {"R", 4} => 4,

    {"U", 5} => 5,
    {"D", 5} => 5,
    {"L", 5} => 5,
    {"R", 5} => 6,

    {"U", 6} => 2,
    {"D", 6} => "A",
    {"L", 6} => 5,
    {"R", 6} => 7,

    {"U", 7} => 3,
    {"D", 7} => "B",
    {"L", 7} => 6,
    {"R", 7} => 8,

    {"U", 8} => 4,
    {"D", 8} => "C",
    {"L", 8} => 7,
    {"R", 8} => 9,

    {"U", 9} => 9,
    {"D", 9} => 9,
    {"L", 9} => 8,
    {"R", 9} => 9,

    {"U", "A"} => 6,
    {"D", "A"} => "A",
    {"L", "A"} => "A",
    {"R", "A"} => "B",

    {"U", "B"} => 7,
    {"D", "B"} => "D",
    {"L", "B"} => "A",
    {"R", "B"} => "C",

    {"U", "C"} => 8,
    {"D", "C"} => "C",
    {"L", "C"} => "B",
    {"R", "C"} => "C",

    {"U", "D"} => "B",
    {"D", "D"} => "D",
    {"L", "D"} => "D",
    {"R", "D"} => "D",
  }

  def go do
    IO.read(:stdio, :all)
    |> String.strip
    |> String.split("\n")
    |> get_code(5, "")
  end

  def get_code([], _pos, code), do: code

  def get_code([line|rest], pos, code) do
    key = do_move(line, pos)
    get_code(rest, key, "#{code}#{key}")
  end

  # Starter case converts easy input (String) into list of chars
  def do_move(line, pos) when is_binary(line), do: line |> String.split("", trim: true) |> do_move(pos)

  # End case
  def do_move([], pos), do: pos

  def do_move([char|rest], pos), do: do_move(rest, @move[{char, pos}])

end

IO.puts TwoB.go
