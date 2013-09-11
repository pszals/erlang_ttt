-module(computer).
-compile(export_all).

take_turn(Board, Piece) ->
  lalalalala.

score_board(Board, Piece) ->
  Winner = game_rules:winner(Board),
  if
    Winner =:= false -> 0;
    Winner =:= Piece -> 1;
    Winner =/= Piece -> -1
  end.

minimax(Board, Piece, Depth) ->
  GameStatus = game_rules:game_over(Board),
  Score = 0,
  BestScore = -1000000,
  case GameStatus of
    true  -> score_board(Board, Piece)/Depth;
    false -> true
  end.
  
