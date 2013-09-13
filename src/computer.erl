-module(computer).
-compile(export_all).

take_turn(Board, Piece) ->
  Square = best_square(Board, Piece),
  game_rules:store_move(Square, Piece, Board).

best_square(Board, Piece) ->
  OpenSquares = game_rules:open_squares(Board),
  ScoreReport = lists:map(space_report(Board, Piece), OpenSquares),
  {Score, Square} = lists:max(ScoreReport),
  Square.

score_board(Board, Piece) ->
  Winner = game_rules:winner(Board),
  if
    Winner =:= false -> 0;
    Winner =:= Piece -> 1.0;
    Winner =/= Piece -> -1.0
  end.

score(Board, Piece) ->
  OpenSquares = game_rules:open_squares(Board),
  score(Board, Piece, 1, OpenSquares, 0). 

score(Board, Piece, Depth, OpenSquares, Score) ->
  GameStatus = game_rules:game_over(Board),
  case GameStatus of
    true  -> score_board(Board, Piece)/Depth;
    false -> 
      Scores = lists:map(next_level_score(Board, Piece, Depth + 1, OpenSquares, Score), OpenSquares),
    lists:sum(Scores)
  end.

space_report(Board, Piece) ->
  fun(Square) ->
    NewBoard = game_rules:store_move(Square, Piece, Board),
    {score(NewBoard, Piece), Square}
  end.

next_level_score(Board, Piece, Depth, OpenSquares, Score) ->
  fun(Square) ->
    NewDepth = Depth + 1,
    NewBoard = game_rules:store_move(Square, Piece, Board),
    NewPiece = switch_piece(Piece),
    NewOpenSquares = game_rules:open_squares(NewBoard),
    score(NewBoard, NewPiece, NewDepth, NewOpenSquares, Score)
  end.

switch_piece(Piece) ->
  if
    Piece =:= x -> o;
    Piece =:= o -> x
  end.
