-module(board).
-compile(export_all).

place_piece(Square, Piece, Board) ->
  H = lists:sublist(Board, Square - 1),
  T = lists:nthtail(Square, Board),
  H ++ [Piece] ++ T.

winner(Row) -> 
  Empty = board_open(Row),
  if 
    Empty      -> false;
    not Empty  -> 
      [H|T] = Row,
      winner(H,T)      
  end.

winner(_,[]) ->
  true;
winner(Head, Tail) ->
  [H|T] = Tail,
  if 
    Head =/= H -> false;
    Head =:= H -> winner(H,T)
  end.

get_info_from_io() ->
  console_io:get_x().

open_squares(Board) ->
  Board -- [x,x,x,x,x,o,o,o,o,o].

board_open(Board) ->
  Pred = fun(X) -> is_integer(X) end,
  lists:any(Pred, Board).

square_open(Square, Board) ->
  Value = lists:nth(Square, Board),
  is_integer(Value).

game_over(Board) ->
  Combos = gather_rows(Board),
  case check_combos(Combos) of
    x -> true;
    o -> true;
    false -> not board_open(Board)
  end.

gather_rows(Board) -> lists:reverse(gather_rows(Board,[])).

gather_rows([], Acc) -> Acc;
gather_rows(Rest, Acc) ->
  gather_rows(lists:nthtail(3,Rest), [lists:sublist(Rest, 3)|Acc]).
  
check_combos(Combos) -> check_combos(Combos, false).

check_combos([], Acc) -> Acc;
check_combos([H|T], Acc) ->
  case winner(H) of
    true  -> check_combos([], lists:nth(1, H));
    false -> check_combos(T, Acc)
  end.
