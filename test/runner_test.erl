-module(runner_test).
-include_lib("eunit/include/eunit.hrl").

get_player_test() ->
  [{ "gets player from list of players",
      ?assertEqual(
        {human, x}, runner:get_player([{human, x}, {human, o}], 1))
    }].

player_type_test() ->
  [{ "gets player type from tuple",
      ?assertEqual(
        human, runner:player_type({human, x}))
    }].

take_turn_test() ->
  [{ "takes turn if human is to play",
      meck:new(human),
      meck:expect(human, take_turn, fun(Board, Players) -> turn_taken end),
      ?assertEqual(
        turn_taken, runner:take_turn(
          [1,2,3,4,5,6,7,8,9], [{human, x},{computer, o}])),
      meck:unload(human)
    },
    
    { "takes turn if computer is to play",
      meck:new(computer),
      meck:expect(computer, take_turn, fun(Board, Players) -> computer_turn_taken end),
      ?assertEqual(
        computer_turn_taken, runner:take_turn(
          [1,2,3,4,5,6,7,8,x], [{human, x},{computer, o}])),
      meck:unload(computer)
    }].

game_loop_test() ->
  [{ "decides when game is over",
      meck:new(console_io),
      meck:expect(console_io, x_wins, fun() -> "Player X Wins" end),
      meck:expect(console_io, display, fun(_) -> "Message 2" end),
      meck:expect(console_io, format_board, fun(_) -> "Formatted" end),
      meck:expect(console_io, display, fun(_) -> "Message 3" end),
      ?assertEqual(
        "Player X Wins", runner:game_loop(true, [x,x,x,4,5,6,7,8,9], o)),
      meck:unload(console_io)
    }].

game_over_test() ->
  [{ "outputs correct game over message",
      meck:new(console_io),
      meck:expect(console_io, format_board, fun(_) -> "Formatted Board" end),
      meck:expect(console_io, display, fun(_) -> "Board" end),
      meck:expect(console_io, x_wins, fun() -> "Player X Wins" end),
      meck:expect(console_io, display, fun(_) -> "Message 2" end),
      ?assertEqual(
        "Player X Wins", runner:game_over([x,x,x,4,5,6,7,8,9])),
      meck:unload(console_io)
    },
    
    { "outputs correct game over message",
      meck:new(console_io),
      meck:expect(console_io, format_board, fun(_) -> "Formatted Board" end),
      meck:expect(console_io, display, fun(_) -> "Board" end),
      meck:expect(console_io, o_wins, fun() -> "Player O Wins" end),
      meck:expect(console_io, display, fun(_) -> "Message 2" end),
      ?assertEqual(
        "Player O Wins", runner:game_over([o,o,o,4,5,6,7,8,9])),
      meck:unload(console_io)
    }].
