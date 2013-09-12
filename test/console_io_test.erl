-module(console_io_test).
-include_lib("eunit/include/eunit.hrl").

setup() ->
  meck:new(io, [unstick, passthrough]).

cleanup() ->
  meck:unload(io).

display_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, console_io:display("Message")),
  cleanup().

prompt_move_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, console_io:prompt_move()),
  cleanup().

game_over_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, console_io:game_over()),
  cleanup().

x_wins_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, console_io:x_wins()),
  cleanup().

o_wins_test() ->
  setup(),
  meck:expect(io, fwrite, fun(_) -> ok end),
  ?assertEqual(ok, console_io:o_wins()),
  cleanup().

format_board_test() ->
  [{ "formats board to a string",
      ?assertEqual(
        "\n123\n456\n789", console_io:format_board([1,2,3,4,5,6,7,8,9]))
    }].

format_input_test() ->
  [{ "formats input from io:get_line",
      ?assertEqual(
        1, console_io:format_input("1"))
    }].

validate_test() ->
  [{ "ensures input is in range 1-9",
      ?assertEqual(
        true, console_io:validate(1))
    },
    
    { "ensures input is in range 1-9",
      ?assertEqual(
        false, console_io:validate(0))
    },
    
    { "ensures correct handling when input is not decimal",
      ?assertEqual(
        false, console_io:validate("asdf"))
    }].

validate_raw_test() ->
  [{ "ensures input is only one character in length",
      ?assertEqual(
        true, console_io:validate_raw("1\n"))
    },
  
    { "returns false if input is not one character in length",
      ?assertEqual(
        false, console_io:validate_raw("12\n"))
    }].
