def start() do
  spawn(server, init, [arguments])
end

def init(arguments) do
  state = initialize_state(arguments),
  loop(State)
end

def loop(state) do
  receive do
    {handle, msg} ->
      newState = handle(msg, state),
      loop(newState)
    stop ->
      terminate(state)
  end
end

def terminate do
  clean_up(state)
end
