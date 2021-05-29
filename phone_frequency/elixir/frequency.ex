defmodule Frequency do

  def start do
    __MODULE__
    |> spawn(:init, [])
    |> Process.register(:frequency)
  end

  def init do
    frequencies = {get_frequencies(), []}
    loop(frequencies)
  end

  def stop,                   do: call(:stop)
  def allocate,               do: call(:allocate)
  def deallocate(frequency),  do: call({:deallocate, frequency})

  def call(message) do
    send :frequency, {:request, self(), message}

    receive do
      {reply, response} -> response
    end        
  end


  def reply(pid, response), do: send pid, {:reply, response}

  def loop(frequencies) do
    receive do
      {:request, pid, :allocate} ->
        {new_frequencies, reply} = allocate(frequencies, pid)
        reply(pid, reply)
        loop(new_frequencies)

      {:request, pid, {:deallocate, frequency}} ->
        new_frequencies = deallocate(frequencies, frequency)
        reply(pid, :ok)
        loop(new_frequencies)

      {:request, pid, :stop} ->
        reply(pid, :ok)
    end        
  end

  def get_frequencies, do: [10, 11, 12, 13]

  defp allocate({[], _allocated} = params, _pid), do: {params, {:error, :no_frequency}}

  defp allocate({[frequency | free], allocated}, pid) do
    {{free, [{frequency, pid} | allocated]}, {:ok, frequency}}
  end

  defp deallocate({free, allocated}, frequency) do
    new_allocated = List.keydelete(allocated, frequency, 1)

    {[frequency | free], new_allocated}
  end
      
end
