start(Argumentos) ->              % Start the Server.
  spawn(server, init, [Argumentos]).

init(Argumentos) ->               % Initalize the internal process state.
  State = initialize_state(Argumentos),
  loop(State).

loop(State) ->                    % Receive and handle message.
  receive
    {handle, Msg} ->
      NewState = handle(Msg, State),
      loop(NewState);
    stop ->
      terminate(State)
  end.

terminate(State) ->               % Clean up prior to termination.
  clean_up(State).
