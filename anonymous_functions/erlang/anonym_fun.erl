-module(anonym_fun).
-export([filter/2, is_even/1]).

filter(P, []) -> [];
filter(P, [X|Xs]) ->
  case P(X) of
    true ->
      [X|filter(P, Xs)];
    _ ->
      filter(P, Xs)
  end.
is_even(x) ->
  x rem 2 == 0.
