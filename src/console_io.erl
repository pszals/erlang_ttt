-module(console_io).
-compile(export_all).

output(Message) ->
  io:format("~s", [Message]).

prompt_move() ->
  output("\nEnter a move: ").

game_over() ->
  output("\nGame Over\n").

invalid_input() ->
  output("\nInput was invalid. Enter a single-digit number.").

validate(Input) ->
  Input > 0 andalso Input < 10. 

get_input() ->
  io:get_line(" ").

format_input(Input) ->
  Tuple = string:to_integer(Input),
  {NewInput, _} = Tuple,
  case NewInput of
    error ->
      invalid_input(),
      get_input();
    _ ->
      NewInput 
  end.

format_board(Board) -> lists:concat(lists:concat(lists:reverse((format_board(Board, []))))).

format_board([], Board) -> Board;
format_board(Rest, Formatted) ->
  format_board(lists:nthtail(3,Rest), [["\n"] ++ lists:sublist(Rest,3)|Formatted]).
