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

