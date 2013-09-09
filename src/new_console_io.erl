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

input() ->
  io:get_line(" ").
