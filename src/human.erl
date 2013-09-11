-module(human).
-compile(export_all).

take_turn(Board, Piece) ->
  Input = new_console_io:input(),
  Formatted = new_console_io:format_input(Input),
  case  validate(Formatted, Board) of
    true -> game_rules:store_move(Formatted, Piece, Board);
    false -> console_io:invalid_input(),
      take_turn(Board, Piece)
  end.



validate(Move, Board) ->
  board:square_open(Move, Board) andalso console_io:validate(Move).
