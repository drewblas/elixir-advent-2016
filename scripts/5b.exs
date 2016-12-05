defmodule FiveB do
  def go(base) do
    find_key(base, 0, %{})
  end

  def md5(data) do
    Base.encode16(:erlang.md5(data), case: :lower)
  end


  def state_to_key(state) do
    state
    |> Enum.into([])
    |> Enum.sort
    |> Enum.map(&(elem(&1, 1)))
    |> Enum.join
  end

  def find_key(base, cnt, state) do
    {pos, char, cnt} = find_collision(base, cnt, "")

    IO.puts "Found #{char} at #{pos} cnt:#{cnt}"

    if pos < 8 && !Map.has_key?(state, pos) do
      IO.puts "Kept"

      state = Map.put(state, pos, char)

      if state |> Map.keys |> length == 8 do
        state_to_key(state)
      else
        find_key(base, cnt+1, state)
      end
    else
      IO.puts "Ignored"
      find_key(base, cnt+1, state)
    end
  end

  # Found a matching hash
  def find_collision(_base, cnt, "00000" <> rest), do: {rest |> String.at(0) |> String.to_integer(16), String.at(rest, 1), cnt}

  # Didn't find a matching hash, so recursively call with the next md5
  def find_collision(base, cnt, _bad_hash) do
    find_collision base, cnt+1, md5(base <> Integer.to_string(cnt))
  end
end

# IO.puts FiveB.go("abc")
IO.puts FiveB.go("reyedfim")
