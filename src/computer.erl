-module(computer).
-compile(export_all).

take_turn(Board, Piece) ->
  Square = best_square(Board, Piece),
  game_rules:store_move(Square, Piece, Board).

best_square(Board, Piece) ->
  case special_case(Board) of
    2 -> 2;
    5 -> 5;
    _ -> 
      OpenSquares = game_rules:open_squares(Board),
      ScoresForSquares = lists:map(fun(Square) -> score_for_square(Board, Piece, Square) end, OpenSquares),
      {_, Square} = lists:max(ScoresForSquares),
      Square
  end.

score_board(Board, MyPiece) ->
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
      score_board(NewBoard, MyPiece)/Depth;
    false -> 
      OpenSquares = game_rules:open_squares(NewBoard),
      Scores = lists:map(fun(OpenSquare) -> 
        score(NewBoard, switch_piece(Piece), MyPiece, OpenSquare, Depth + 1) end, 
        OpenSquares),
      lists:min(Scores)
  end.

score_for_square(Board, Piece, Square) ->
  {score(Board, Piece, Piece, Square, 1), Square}.

switch_piece(Piece) ->
  if
    Piece =:= x -> o;
    Piece =:= o -> x
  end.

special_case(Board) ->
  case Board of
    [
      x,2,3,
      4,o,6,
      7,8,x
    ] -> 2;
    [
      1,2,x,
      4,o,6,
      x,8,9
    ] -> 2;
    [
      _,2,_,
      4,5,6,
      _,8,_
    ] -> 5;
    [
      1,_,3,
      _,5,_,
      7,_,9
    ] -> 5;
    _ -> false
  end.
