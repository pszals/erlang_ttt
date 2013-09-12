-module(computer).
-compile(export_all).

take_turn(Board, Piece) ->
  lists:max.

score_board(Board, Piece) ->
  Winner = game_rules:winner(Board),
  if
    Winner =:= false -> 0;
    Winner =:= Piece -> 1;
    Winner =/= Piece -> -1
  end.

%                       mini-max
%                     {space, amount}
%                        summer
%                        (every possible move)
%                        [1]
%                         2
%                        / /  
%                     (0)D /\(2)
%                       0 W L
%                         1 1 
% entry
minimax(Board, Piece) ->
  OpenSquares = game_rules:open_squares(Board),
  % Map minimax over these open squares
  % lists:map(next_level_score(Board, Piece, Depth, OpenSquares, Score), OpenSquares)
  % Returning [{1, 10}, {space, score}] return best scored space
  minimax(Board, Space, Piece, 1, OpenSquares, 0). 

minimax(Board, Depth, OpenSquares, Score) ->
  GameStatus = game_rules:game_over(Board),
  BestScore = -1000000,
  case GameStatus of
    true  -> score_board(Board, Piece)/Depth;
    false -> 
      lists:map(next_level_score(Board, Piece, Depth, OpenSquares, Score), OpenSquares)
  end.

next_level_score(Board, Piece, Depth, OpenSquares, Score) ->
  fun(Square) ->
      NewDepth = Depth + 1,
      NewBoard = game_rules:store_move(Square, Piece, Board),
      NewPiece = switch_piece(Piece),
      NewOpenSquares = game_rules:open_squares(NewBoard),
      minimax(NewBoard, NewPiece, NewDepth, NewOpenSquares, Score)
  end.

switch_piece(Piece) ->
  if
    Piece =:= x -> o;
    Piece =:= o -> x
  end.
