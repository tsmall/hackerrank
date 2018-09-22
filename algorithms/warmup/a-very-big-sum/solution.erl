-module(solution).
-export([main/0]).

main() ->
  Array = get_input_array(),
  Result = sum(Array),
  print_result(Result),
  ok.

sum(Numbers) ->
  sum(Numbers, 0).

sum([], Sum) ->
  Sum;
sum([H|T], Sum) ->
  sum(T, Sum + H).

get_input_array() ->
  _CountLine = io:get_line(""),
  ArrayLine = string:chomp(io:get_line("")),
  Array = re:split(ArrayLine, "\\s+", [{return, list}, trim]),
  [to_integer(N) || N <- Array].

to_integer(N) ->
  {I, _} = string:to_integer(N),
  I.

print_result(Result) ->
  io:fwrite("~w~n", [Result]).
