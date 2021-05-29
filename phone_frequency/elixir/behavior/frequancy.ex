defmodule Frequency_Worker do

  alias Frequency_Server

  def start, do: Frequency_Server.start(__MODULE__, [])

  def init(_args) do
    {get_freq, []}
  end

  def terminate(_frequencies), do: :ok

  def handle({:allocate, pid}, frequencies) do
    allocate(frequencies, pid)
  end

  def handle({:deallocate, freq}, frequencies) do
    {deallocate(frequencies, freq), :ok}
  end

  def stop, do: Frequency_Server.stop(__MODULE__)
  def allocate, do: Frequency_Server.call(__MODULE__, {:allocate, self()})
  def deallocate(freq), do: Frequency_Server.call(__MODULE__, {:deallocate, freq})

  defp get_freq, do: [10,11,12]

  # This is a internal helper functions
  def allocate({[], allocated}, _pid) do
    {{[], allocated}, {:error, :no_frequency}}
  end

  def allocate({[freq | free], allocated}, pid) do
    {{free, [{freq, pid} | allocated]}, {:ok, freq}}
  end

  def deallocate({free, allocated}, freq) do
    new_allocated = List.keydelete(allocated, freq, 1)

    {[freq | free], new_allocated}
  end

end
