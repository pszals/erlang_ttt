-module(new_console_io).
-compile(export_all).

display(Message) ->
  io:fwrite(Message).

prompt_move() ->
  display("\nEnter a move: ").

game_over() ->
  display("\nGame Over\n").

x_wins() ->
  display("\nPlayer X wins!\n").

o_wins() ->
  display("\nPlayer O wins!\n").

configure_game() ->
  display("\nEnter 1 for H v. H, 2 for H v. C, or 3 for C v. C\n").

input() ->
  io:get_line(" ").

invalid_input() ->
  display("\nInput was invalid. Enter a single-digit number.").

format_board(Board) -> lists:concat(lists:concat(lists:reverse((format_board(Board, []))))).

format_board([], Board) -> Board;
format_board(Rest, Formatted) ->
  format_board(lists:nthtail(3,Rest), [["\n"] ++ lists:sublist(Rest,3)|Formatted]).

format_input(Input) ->
  Tuple = string:to_integer(Input),
  {NewInput, _} = Tuple,
  case NewInput of
    error ->
      invalid_input(),
      input();
    _ ->
      NewInput 
  end.
