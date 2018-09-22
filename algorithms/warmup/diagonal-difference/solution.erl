-module(solution).
-export([main/0]).


main() ->
  {matrix, {size, Size}, {data, Data}} = get_input(),
  {diagonals, {left, Left}, {right, Right}} = get_diagonals(Size, Data),
  Result = abs(lists:sum(Left) - lists:sum(Right)),
  io:fwrite("~w~n", [Result]),
  ok.


get_diagonals(Size, Rows) ->
  get_diagonals(Size, 1, Rows, [], []).

get_diagonals(_, _, [], Left, Right) ->
  {diagonals, {left, Left}, {right, Right}};
get_diagonals(Size, CurrentRow, [Row|Rest], Left, Right) ->
  NewLeft = lists:nth(CurrentRow, Row),
  NewRight = lists:nth(Size - CurrentRow + 1, Row),
  get_diagonals(Size, CurrentRow + 1, Rest, [NewLeft|Left], [NewRight|Right]).


get_input() ->
  Size = to_integer(io:get_line("")),
  Data = get_matrix(),
  {matrix, {size, Size}, {data, Data}}.


get_matrix() ->
  get_matrix([]).

get_matrix(RowsThusFar) ->
  case io:get_line("") of
    eof -> RowsThusFar;
    Row -> get_matrix(RowsThusFar ++ [parse_row(Row)])
  end.


parse_row(RowString) ->
  StringList = re:split(RowString, "\\s+", [{return, list}, trim]),
  [to_integer(N) || N <- StringList].


to_integer(String) ->
  {I, _} = string:to_integer(String),
  I.
