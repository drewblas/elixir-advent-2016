defmodule FiveA do
  def go(base) do
    find_key(base, 0, [])
  end

  def md5(data) do
    Base.encode16(:erlang.md5(data), case: :lower)
  end

  def find_key(_base, _cnt, key) when length(key) == 8, do: key |> Enum.reverse |> Enum.join

  def find_key(base, cnt, key) do
    {char, cnt} = find_collision(base, cnt, "")
    IO.puts "Found #{char} #{cnt}"

    find_key(base, cnt+1, [char|key])
  end

  # Found a matching hash
  def find_collision(_base, cnt, "00000" <> rest), do: {String.at(rest, 0), cnt}

  # Didn't find a matching hash, so recursively call with the next md5
  def find_collision(base, cnt, _bad_hash) do
    find_collision base, cnt+1, md5(base <> Integer.to_string(cnt))
  end
end

# IO.puts FiveA.go("abc")
IO.puts FiveA.go("reyedfim")
