-module(human).
-compile(export_all).

take_turn(Board, Piece) ->
  Input = new_console_io:input(),
  Formatted = new_console_io:format_input(Input),
  case  human_validate(Formatted, Board) of
    true -> game_rules:store_move(Formatted, Piece, Board);
    false -> console_io:invalid_input(),
      take_turn(Board, Piece)
  end.

human_validate(Move, Board) ->
  game_rules:square_open(Move, Board) andalso new_console_io:validate(Move).
