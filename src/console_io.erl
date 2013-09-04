-module(console_io).
-compile(export_all).

output(Message) ->
  io:format("~s", [Message]).

prompt_move() ->
  output("Enter a move: ").

game_over() ->
  output("Game Over").

invalid_input() ->
  output("Input was invalid.").

validate(Input) ->
  Input > 0 andalso Input < 10.

get_input() ->
  Input = io:fread(" ", "~d"),
  Input.

format_board(Board) -> lists:concat(lists:concat(lists:reverse((format_board(Board, []))))).

format_board([], Board) -> Board;
format_board(Rest, Formatted) ->
  format_board(lists:nthtail(3,Rest), [lists:sublist(Rest,3) ++ ["\n"]|Formatted]).


