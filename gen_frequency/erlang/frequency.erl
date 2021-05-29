-module(frequency).
-behavior(gen_server).

-export([[start_link/1, init/1, ...]]).

start() ->
  gen_server:start_link({local, frequency}, frequency, [], []).

init(_Args) ->
  Frequencies = {get_frequencies(), []},
  {ok, Frequencies}.

get_frequencies() -> [10,11,12,13,14].


