-module(solution).
-export([main/0]).
-import(os, [getenv/1]).

array_sum(Array) ->
  array_sum(Array, 0).

array_sum([], Sum) ->
  Sum;
array_sum([H|T], Sum) ->
  array_sum(T, Sum + H).

to_integer(N) ->
  {I, _} = string:to_integer(N),
  I.

get_input_array() ->
  _ArrayCount = io:get_line(""),
  Array = re:split(string:chomp(io:get_line("")), "\\s+", [{return, list}, trim]),
  [to_integer(N) || N <- Array].

print_result(Result) ->
  io:fwrite("~w~n", [Result]).

main() ->
  Array = get_input_array(),
  Result = array_sum(Array),
  print_result(Result),
  ok.
