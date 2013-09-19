-module(computer).
-compile(export_all).

take_turn(Board, Piece) ->
  Square = best_square(Board, Piece),
  game_rules:store_move(Square, Piece, Board).

best_square(Board, Piece) ->
  case special_case(Board) of
    2 -> 2;
    _ -> 
      OpenSquares = game_rules:open_squares(Board),
      ScoresForSquares = lists:map(fun(Square) -> score_for_square(Board, Piece, Square) end, OpenSquares),
      erlang:display(ScoresForSquares),
      {Score, Square} = lists:max(ScoresForSquares),
      Square
  end.

score_board(Board, Piece, MyPiece) ->
  Winner = game_rules:winner(Board),
  if
    Winner =:= false -> 0;
    Winner =:= MyPiece -> 1;
    Winner =/= MyPiece -> -1
  end.

score(Board, Piece, MyPiece, Square, Depth) ->
  NewBoard = game_rules:store_move(Square, Piece, Board),
  GameStatus = game_rules:game_over(NewBoard),
  case GameStatus of
    true  -> 
      if 
        true -> score_board(NewBoard, Piece, MyPiece)/Depth
      end;
    false -> 
      OpenSquares = game_rules:open_squares(NewBoard),
      Scores = lists:map(fun(NextSquare) -> 
            score(NewBoard, switch_piece(Piece), MyPiece, NextSquare, Depth + 100) end, 
            OpenSquares),
      lists:sum(Scores)
  end.

score_for_square(Board, Piece, Square) ->
  {score(Board, Piece, Piece, Square, 1), Square}.

switch_piece(Piece) ->
  if
    Piece =:= x -> o;
    Piece =:= o -> x
  end.

special_case(Board) ->
  if
    Board =:= [
      x,2,3,
      4,o,6,
      7,8,x
    ] -> 2;
    Board =:= [
      1,2,x,
      4,o,6,
      x,8,9
    ] -> 2;
    true -> false
  end.
