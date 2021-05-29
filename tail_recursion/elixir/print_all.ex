defmodule Print_all_as_erlang do
  
  def print_all([]), do: :io.format("\n")

  def print_all([x | xs]) do
    :io.format("~s\t", [x])
    print_all(xs)
  end

end

defmodule Print_all_as_elixir do
  
  def print_all([]), do: :ok

  def print_all([x | xs]) do
    IO.puts x
    print_all(xs)
  end

end


