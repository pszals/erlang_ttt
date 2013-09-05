-module(console_io).
-compile(export_all).

output(Message) ->
  io:format("~s", [Message]).

prompt_move() ->
  output("\nEnter a move: ").

game_over() ->
  output("\nGame Over\n").

invalid_input() ->
  output("\nInput was invalid.").

validate(Input) ->
  Input > 0 andalso Input < 10.

get_input() ->
  Input = io:fread(" ", "~d"),
  {_,Selection} = Input,
  Formatted = lists:nth(1, Selection),
  Formatted.

format_board(Board) -> lists:concat(lists:concat(lists:reverse((format_board(Board, []))))).

format_board([], Board) -> Board;
format_board(Rest, Formatted) ->
  format_board(lists:nthtail(3,Rest), [["\n"] ++ lists:sublist(Rest,3)|Formatted]).
