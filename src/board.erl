-module(board).
-compile(export_all).

place_piece(Square, Piece, Board) ->
  H = lists:sublist(Board, Square - 1),
  T = lists:nthtail(Square, Board),
  H ++ [Piece] ++ T.

find_winner(Board) ->
  NewBoard = lists:split(3, Board),
  {H, T} = NewBoard,
  Pred = lists:nth(1, H),
  if lists:all(Pred, H) ->
      lists:nth(1, H)
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
