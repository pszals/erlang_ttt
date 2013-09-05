-module(runner_test).
-include_lib("eunit/include/eunit.hrl").

switch_piece_test() ->
  [{ "switches current piece",
      ?assertEqual(
        o, runner:switch_piece(x))
    }].
