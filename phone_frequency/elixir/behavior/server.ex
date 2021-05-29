defmodule Frequency_Server do

  def start(name, args) do
    __MODULE__
    |> spawn(:init, [name, args])
    |> Process.register(:frequency)
  end

  def init(mod, args) do
    state = mod.init(args)
    loop(mod, state)
  end

  def stop(name) do
    send :name, {:stop, self()}

    receive do
      {:reply, response} -> response
    end  
  end

  def call(name, message) do
    send :frequency, {:request, self(), message}

    receive do
      {reply, response} -> response
    end  
  end

  def reply(pid, response), do: send pid, {:reply, response}  

  def loop(mod, state) do
      receive do
        {:request, pid, message} ->
          {new_state, response} = mod.handle(message, state)
          reply(pid, response)
          loop(mod, new_state)

        {:stop, pid} ->
          response = mod.terminate(state)          
          reply(pid, response)        
      end      
  end
  
end
