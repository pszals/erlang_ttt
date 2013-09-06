-module(console_io_test).
-include_lib("eunit/include/eunit.hrl").

output_test() ->
  [{ "outputs message to console",
      ?assertEqual(ok, console_io:output("message"))
  }].

prompt_move_test() ->
  [{ "prompts for a move",
      ?assertEqual(ok, console_io:prompt_move())
  }].

game_over_test() ->
  [{ "outputs game over message",
      ?assertEqual(ok, console_io:game_over())
    }].

invalid_input_test() ->
  [{ "sends input error message",
      ?assertEqual(ok, console_io:invalid_input())
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

format_input_test() ->
  [{ "formats input from io:fread",
      ?assertEqual(
        1, console_io:format_input("1\n"))
    }].

format_board_test() ->
  [{ "splits board into three separate rows",
      ?assertEqual(
        "\n123\n456\n789", console_io:format_board([1,2,3,4,5,6,7,8,9]))
    }].
