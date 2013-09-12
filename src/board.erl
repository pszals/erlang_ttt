-module(board).
-compile(export_all).

make_board(Size) ->
  lists:seq(1, Size).

square_at(Location, Board) ->
  lists:nth(Location, Board).
