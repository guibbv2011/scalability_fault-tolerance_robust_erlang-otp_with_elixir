-module(print_all).
-export([print_all/1]).

print_all([]) ->
  io:format("~n");
print_all([X|Xs]) ->
  io:format("~s\t", [X]),
  print_all(Xs).
