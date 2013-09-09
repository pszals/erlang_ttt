-module(new_console_io_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(io, [unstick, passthrough]).

cleanup() ->
  meck:unload(io).

display_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, new_console_io:display("Message")),
  cleanup().

prompt_move_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, new_console_io:prompt_move()),
  cleanup().

game_over_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, new_console_io:game_over()),
  cleanup().

x_wins_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, new_console_io:x_wins()),
  cleanup().

o_wins_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, new_console_io:o_wins()),
  cleanup().

