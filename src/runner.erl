-module(runner).
-compile(export_all).

game_loop(GameOver, Board, Piece) ->
  if
    GameOver =:= game_over -> 
      console_io:output(console_io:format_board(Board)),
      console_io:game_over();
    GameOver =/= game_over ->
      take_turn(Board, Piece)
  end.

take_turn(Board, Piece) ->
  console_io:output(console_io:format_board(Board)),
  console_io:prompt_move(),
  Move = console_io:format_input(console_io:get_input()),
  case console_io:validate(Move) andalso board:square_open(Move, Board) of 
      false -> 
        console_io:invalid_input(),
        take_turn(Board, Piece);
      true ->
          NewBoard = board:place_piece(Move, Piece, Board),
          NewPiece = switch_piece(Piece),
          GameOver = board:game_over(NewBoard),
          game_loop(GameOver, NewBoard, NewPiece)
  end.


switch_piece(Piece) ->
  if 
    Piece =:= x -> o;
    Piece =/= x -> x
  end.

play_game() ->
  game_loop(false, [1,2,3,4,5,6,7,8,9], x).
