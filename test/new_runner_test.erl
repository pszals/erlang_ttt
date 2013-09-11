-module(new_runner_test).
-include_lib("eunit/include/eunit.hrl").

get_player_test() ->
  [{ "gets player from list of players",
      ?assertEqual(
        {human, x}, new_runner:get_player([{human, x}, {human, o}], 1))
    }].

player_type_test() ->
  [{ "gets player type from tuple",
      ?assertEqual(
        human, new_runner:player_type({human, x}))
    }].

take_turn_test() ->
  [{ "takes turn if human is to play",
      meck:new(human),
      meck:expect(human, take_turn, fun(Board, Players) -> turn_taken end),
      ?assertEqual(
        turn_taken, new_runner:take_turn(
          [1,2,3,4,5,6,7,8,9], [{human, x},{computer, o}])),
      meck:unload(human)
    },
    
    { "takes turn if computer is to play",
      meck:new(computer),
      meck:expect(computer, take_turn, fun(Board, Players) -> computer_turn_taken end),
      ?assertEqual(
        computer_turn_taken, new_runner:take_turn(
          [1,2,3,4,5,6,7,8,x], [{human, x},{computer, o}])),
      meck:unload(computer)
    }].

game_loop_test() ->
  [{ "decides when game is over",
      meck:new(new_console_io),
      meck:expect(new_console_io, game_over, fun() -> "Game Over" end),
      meck:expect(new_console_io, display, fun(_) -> "Message 2" end),
      meck:expect(new_console_io, format_board, fun(_) -> "Formatted" end),
      meck:expect(new_console_io, display, fun(_) -> "Message 3" end),
      ?assertEqual(
        "Game Over", new_runner:game_loop(true, [x], o)),
      meck:unload(new_console_io)
    }].
