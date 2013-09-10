-module(configuration_test).
-include_lib("eunit/include/eunit.hrl").

configure_players_test() ->
  [{ "creates two human players",
      ?assertEqual(
        [{human, x}, {human, o}], configuration:configure_players(1))
    },
    
    { "creates a computer opponent",
      ?assertEqual(
        [{human, x}, {computer, o}], configuration:configure_players(2))
    },

    { "creates two computer players",
      ?assertEqual(
        [{computer, x}, {computer, o}], configuration:configure_players(3))
    }].

configure_game_test() ->
  [{ "uses input to configure players",
      meck:new(new_console_io),
      meck:expect(new_console_io, configure_game, fun() -> "hello" end),
      meck:expect(new_console_io, input, fun() -> "1" end),
      meck:expect(new_console_io, format_input, fun(Input) -> 1 end),
      ?assertEqual(
        [{human, x}, {human, o}], configuration:configure_game()),
      meck:unload(new_console_io)
    },
    
    { "uses input to configure players, will re-prompt if input is invalid",
      meck:new(new_console_io),
      meck:expect(new_console_io, configure_game, fun() -> "hello" end),
      meck:expect(new_console_io, input, fun() -> "9" end),
      meck:expect(new_console_io, format_input, fun(Input) -> 9 end),
      meck:expect(new_console_io, configure_game, fun() -> "hello" end),
      meck:expect(new_console_io, input, fun() -> "1" end),
      meck:expect(new_console_io, format_input, fun(Input) -> 1 end),
      ?assertEqual(
        [{human, x}, {human, o}], configuration:configure_game()),
      meck:unload(new_console_io)
    }].
