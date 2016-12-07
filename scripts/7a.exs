defmodule SevenA do
  def go do
    IO.read(:stdio, :all)
    |> String.strip
    |> String.split("\n", trim: true)
    |> Enum.map(&supports_tls/1)
    |> Enum.count(&(&1))
  end

  def supports_tls(str) do
    {outsides, insides} = split(str)
    Enum.any?(outsides, &abba?/1) && !Enum.any?(insides, &abba?/1)
  end

  def split(str) do
    list = String.split(str, ["[","]"])
    {
      list |> Enum.take_every(2),
      list |> tl |> Enum.take_every(2)
    }
  end

  def abba?(str) do
    ~r/([a-z])(?!\1)([a-z])\2\1/ |> Regex.match?(str)
  end
end

IO.inspect SevenA.go
