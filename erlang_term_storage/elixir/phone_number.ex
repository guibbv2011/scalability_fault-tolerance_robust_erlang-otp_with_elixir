defmodule Phone_Number do

  def new do
    :ets.new(:n2pid, [:public, :named_table])
    :ets.new(:pid2n, [:public, :named_table])
  end

  def attach(num) do
    :ets.insert(:n2pid, {num, self()})
    :ets.insert(:pid2n, {self(), num})
  end

  def detach do
    case :ets.lookup(:pid2n, self()) do
      [{pid, num}] ->
        :ets.delete(:pid2n, pid)
        :ets.delete(:n2pid, num)  
      [] ->
        :ok
    end    
  end

  def lookup_id(num) do
    case :ets.lookup(:n2pid, num) do
      [] -> {:error, :invalid}
      [{num, pid}] -> {:ok, pid}
    end
  end

  def lookup_ms(pid) do
    case :ets.lookup(:pid2n, pid) do
      [] -> {:error, :invalid}
      [{pid, num}] -> {:ok, num}
    end
  end

end
