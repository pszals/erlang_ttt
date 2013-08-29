-module(console_io).
-compile(export_all).

output(Message) ->
  io:format("~s", [Message]).

get_x() ->
  x.
