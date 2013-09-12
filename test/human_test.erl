-module(human_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(console_io).

cleanup() ->
  meck:unload(console_io).

take_turn_test() ->
  [{ "takes a turn",
      setup(),
      meck:expect(console_io, input, fun() -> "1" end),
      meck:expect(console_io, format_input, fun("1") -> 1 end),
      meck:expect(console_io, validate, fun(1) -> true end),
      ?assertEqual(
        [x], human:take_turn([1], x)),
      cleanup()
    },
    
    { "validates a wrong move and then takes a turn",
      setup(),
      meck:expect(console_io, input, fun() -> "4" end),
      meck:expect(console_io, format_input, fun("4") -> 4 end),
      meck:expect(console_io, input, fun() -> "1" end),
      meck:expect(console_io, format_input, fun("1") -> 1 end),
      meck:expect(console_io, validate, fun(1) -> true end),
      ?assertEqual(
        [o,2,3,x], human:take_turn([1,2,3,x], o)),
      cleanup()
    }].
