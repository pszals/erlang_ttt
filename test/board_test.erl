-module(board_test).
-include_lib("eunit/include/eunit.hrl").

place_piece_test() ->
  [{ "places piece on board",
      ?assertEqual(
        [x,2,3,4,5,6,7,8,9],
        board:place_piece(1,x,[1,2,3,4,5,6,7,8,9]))},

    { "places piece in different location",
      ?assertEqual(
        [1,x,3,4,5,6,7,8,9],
        board:place_piece(2,x,[1,2,3,4,5,6,7,8,9]))
    },
    
    { "places different piece in different location",
      ?assertEqual(
        [1,2,3,4,o,6,7,8,9],
        board:place_piece(5,o,[1,2,3,4,5,6,7,8,9]))
    }].

find_winner_test() ->
  [{ "checks for winner on board",
      ?assertEqual(
        x, board:find_winner([x,x,x,4,5,6,7,8,9]))
    },
    
    { "checks for winner on board",
      ?assertEqual(
        o, board:find_winner([o,o,o,4,5,6,7,8,9]))
    }].

talk_to_module_test() ->
  [{ "talks to console_io module",
      ?assertEqual(
        x, board:get_info_from_io())
    }].

open_squares_test() ->
  [{ "returns list of open squares",
      ?assertEqual(
        [5], board:open_squares([x,o,x,o,5,o,o,x,o]))
    }].

board_open_test() ->
  [{ "returns true if there are empty squares on board",
      ?assertEqual(
        true, board:board_open([1,2,3,4,5,6,7,8,9]))
    },
    
    { "returns true if there are empty squares on board",
      ?assertEqual(
        false, board:board_open([x,o,x,o,x,o,o,x,o]))
    }].

square_open_test() ->
  [{ "returns true if given square is available",
      ?assertEqual(
        true, board:square_open(1, [1,2,3,4,5,6,7,8,9]))
    },
    
    { "returns true if given square is available",
      ?assertEqual(
        false, board:square_open(1, [x,2,3,4,5,6,7,8,9]))
    }].
