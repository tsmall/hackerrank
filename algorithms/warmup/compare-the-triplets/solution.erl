-module(solution).
-export([main/0]).

compare_scores(A, B) ->
  compare_scores(A, B, 0, 0).

compare_scores([], _, AScore, BScore) ->
  [AScore, BScore];
compare_scores(_, [], AScore, BScore) ->
  [AScore, BScore];
compare_scores([AHead|ARest], [BHead|BRest], AScore, BScore) when AHead > BHead ->
  compare_scores(ARest, BRest, AScore + 1, BScore);
compare_scores([AHead|ARest], [BHead|BRest], AScore, BScore) when AHead < BHead ->
  compare_scores(ARest, BRest, AScore, BScore + 1);
compare_scores([AHead|ARest], [BHead|BRest], AScore, BScore) when AHead =:= BHead ->
  compare_scores(ARest, BRest, AScore, BScore).

main() ->
  AScores = get_input_array(),
  BScores = get_input_array(),
  Result  = compare_scores(AScores, BScores),
  
  print_result(Result),
  ok.

get_input_array() ->
  Line = string:chomp(io:get_line("")),
  Array = re:split(Line, "\\s+", [{return, list}, trim]),
  [to_integer(N) || N <- Array].

to_integer(N) ->
  {I, _} = string:to_integer(N),
  I.

print_result([]) ->
  ok;
print_result([Score|Rest]) ->
  io:fwrite("~w ", [Score]),
  print_result(Rest).
