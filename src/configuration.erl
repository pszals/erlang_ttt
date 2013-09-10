-module(configuration).
-compile(export_all).

configure_players(Selection) ->
  if
    Selection =:= 1 -> [{human, x}, {human, o}];
    Selection =:= 2 -> [{human, x}, {computer, o}];
    Selection =:= 3 -> [{computer, x}, {computer, o}];
    true -> "Error"
  end.

configure_game() -> 
  new_console_io:configure_game(),
  Input = new_console_io:input(),
  FormattedInput = new_console_io:format_input(Input),
  Output = configure_players(FormattedInput),
  case Output of
    [{_,_},{_,_}] = Output -> Output;
    "Error"       = Output -> configure_game()
  end.
