defmodule Echo do

  def go(message) do

    # @doc "burn Pid Process" #1
    pid = spawn(Echo, :loop, [])

    # @doc "send message from self" #2
    send pid, {message, self()}

    receive do
      #5
      msg -> IO.puts("#{msg}")
    end

   # BOTH same func which is shown's message of stack from self() process
     # :erlang.process_info self(), :messages
     # Process.info self(), :messages

  end

  def loop do
    # @doc "pid receive message of self" #3
    receive do
      #  @doc "resend message from self" #4
      {msg, from_pid} ->
        send from_pid, msg
    end
  end
end

