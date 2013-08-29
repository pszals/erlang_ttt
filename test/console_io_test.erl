-module(console_io_test).
-include_lib("eunit/include/eunit.hrl").

output_test() ->
  [{ "outputs message to console",
      ?assertEqual(ok, console_io:output("message"))
  }].
