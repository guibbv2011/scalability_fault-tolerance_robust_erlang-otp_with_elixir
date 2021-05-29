-module(echo).
-export([go/1, loop/0]).

go(Message) ->
  Pid = spawn(echo, loop, []),
  Pid ! {self(), Message},
  receive
    {Pid, Message} ->
      io:format("~s~n", [Message])
  end,
  Pid ! stop.

loop() ->
  receive
    {From, Message} ->
      From ! {self(), Message},
      loop();
    stop ->
      ok
  end.

