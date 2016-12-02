defmodule TwoA do
  @move %{
    {"U", 1} => 1,
    {"D", 1} => 3,
    {"L", 1} => 1,
    {"R", 1} => 1,

    {"U", 2} => 2,
    {"D", 2} => 5,
    {"L", 2} => 1,
    {"R", 2} => 3,

    {"U", 3} => 3,
    {"D", 3} => 6,
    {"L", 3} => 2,
    {"R", 3} => 3,

    {"U", 4} => 1,
    {"D", 4} => 7,
    {"L", 4} => 4,
    {"R", 4} => 5,

    {"U", 5} => 2,
    {"D", 5} => 8,
    {"L", 5} => 4,
    {"R", 5} => 6,

    {"U", 6} => 3,
    {"D", 6} => 9,
    {"L", 6} => 5,
    {"R", 6} => 6,

    {"U", 7} => 4,
    {"D", 7} => 7,
    {"L", 7} => 7,
    {"R", 7} => 8,

    {"U", 8} => 5,
    {"D", 8} => 8,
    {"L", 8} => 7,
    {"R", 8} => 9,

    {"U", 9} => 6,
    {"D", 9} => 9,
    {"L", 9} => 8,
    {"R", 9} => 9,
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

IO.puts TwoA.go
