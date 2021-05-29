defmodule Factorial do
  def factorial(0), do: 1
  def factorial(n) when n > 0, do: n * factorial(n-1)
end

defmodule TailRecursive do
  def factorial(n), do: _fact(n, 1)
  defp _fact(0, acc) when is_number, do: acc
  defp _fact(n, acc) when is_number and n > 0, do: _fact(n-1, acc*n)
end

