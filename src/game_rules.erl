-module(game_rules).
-compile(export_all).

store_move(Location, Piece, Board) ->
  H = lists:sublist(Board, Location - 1),
  T = lists:nthtail(Location, Board),
  H ++ [Piece] ++ T.

undo_store_move(Location, Board) ->
  H = lists:sublist(Board, Location - 1),
  T = lists:nthtail(Location, Board),
  H ++ [Location] ++ T.

square_open(Location, Board) ->
  Value = lists:nth(Location, Board),
  is_integer(Value).

game_over(Board) ->
  Combos = gather_combos(Board),
  case check_combos(Combos) of
    x -> true;
    o -> true;
    false -> not board_open(Board)
  end.



%%%%%%%%%%%% PRIVATE %%%%%%%%%%%%%%%%%%%

board_open(Board) ->
  Pred = fun(X) -> is_integer(X) end,
  lists:any(Pred, Board).

winner(Board) ->
  Combos = gather_combos(Board),
  check_combos(Combos).

gather_combos(Board) ->
  gather_rows(Board) ++ columns(Board) ++ gather_diagonals(Board).

combo_winner(_,[]) -> true;
combo_winner(Head, Tail) ->
  [H|T] = Tail,
  if
    Head =/= H -> false;
    Head =:= H -> combo_winner(H,T)
  end.

combo_winner(Combo) ->
  [H|T] = Combo,
  combo_winner(H,T).

check_combos([], Winner) -> Winner;
check_combos([H|T], Winner) ->
  case combo_winner(H) of
    true  -> check_combos([], lists:nth(1, H));
    false -> check_combos(T, Winner)
  end.

check_combos(Combos) -> check_combos(Combos, false).

gather_rows(Board) -> lists:reverse(gather_rows(Board, [])).

gather_rows([], Gathered) -> Gathered;
gather_rows(Rest, Gathered) ->
  gather_rows(lists:nthtail(3, Rest), [lists:sublist(Rest, 3)|Gathered]).

columns(_, Gathered, 4) -> Gathered;
columns(Board, Gathered, Acc) ->
  Rows = gather_rows(Board),
  Column = lists:map(column_fun(Acc), Rows), 
  GatheredRows = Gathered ++ [Column],
  columns(Board, GatheredRows, Acc + 1).

columns(Board) -> columns(Board, [], 1).

column_fun(ColumnNumber) ->
  fun(BoardRow) -> lists:nth(ColumnNumber, BoardRow) end.
diagonal_one(Board) ->
  [lists:nth(1, Board)] ++ [lists:nth(5, Board)] ++ [lists:nth(9, Board)].

diagonal_two(Board) ->
  [lists:nth(3, Board)] ++ [lists:nth(5, Board)] ++ [lists:nth(7, Board)].

gather_diagonals(Board) ->
  [diagonal_one(Board)] ++ [diagonal_two(Board)].
