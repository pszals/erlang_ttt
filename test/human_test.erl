-module(human_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(new_console_io).

cleanup() ->
  meck:unload(new_console_io).

take_turn_test() ->
  [{ "takes a turn",
      setup(),
      meck:expect(new_console_io, input, fun() -> "1" end),
      meck:expect(new_console_io, format_input, fun("1") -> 1 end),
      ?assertEqual(
        [x], human:take_turn([1], x)),
      cleanup()
    }].
