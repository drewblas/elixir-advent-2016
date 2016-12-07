defmodule SevenB do
  def go do
    IO.read(:stdio, :all)
    |> String.strip
    |> String.split("\n", trim: true)
    |> Enum.map(&supports_ssl/1)
    |> Enum.count(&(&1))
  end

  def supports_ssl(str) do
    {outsides, insides} = split(str)

    all_abas = Enum.flat_map(outsides, &(find_matches(&1)))
    length(all_abas) > 0 && Enum.any?(insides, &(bab?(&1, all_abas)))
  end

  def split(str) do
    list = String.split(str, ["[","]"])
    {
      list |> Enum.take_every(2),
      list |> tl |> Enum.take_every(2)
    }
  end

  def find_matches(str), do: find_matches(str, [])
  def find_matches("", list), do: list |> Enum.flat_map(&(&1)) |> Enum.uniq

  def find_matches(<<_char , rest :: binary>>=str, list) do
    add = ~r/([a-z])(?!\1)([a-z])\1/ |> Regex.scan(str) |> Enum.map(&hd/1)
    find_matches(rest, [add|list])
  end

  def bab?(str, abas) do
    babs = find_matches(str)
    wanted_babs = abas |> Enum.map(&flip_aba/1)

    missing = babs -- wanted_babs
    intersection = babs -- missing
    length(intersection) > 0
  end

  def flip_aba(<<a,b,_a>>), do: <<b,a,b>>
end

IO.inspect SevenB.go
