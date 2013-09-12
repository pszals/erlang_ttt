-module(board_test).
-include_lib("eunit/include/eunit.hrl").

make_board_test() ->
  [{ "creates a board of any size",
      ?assertEqual(
        [1,2,3], board:make_board(3))
    }].

square_at_test() ->
  [{ "returns value of square at given index",
      ?assertEqual(
        "value", board:square_at(2, [1,"value",3]))
    }].
