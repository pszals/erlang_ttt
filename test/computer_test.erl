-module(computer_test).
-include_lib("eunit/include/eunit.hrl").

score_board_test() ->
  [{ "provides a 1 for win, -1 for loss, and 0 for tie",
      ?assertEqual(
        1, computer:score_board([x,x,x,4,5,6,7,8,9], x, x))
    },
    
    { "provides a 1 for win, -1 for loss, and 0 for tie",
      ?assertEqual(
        -1, computer:score_board([x,x,x,4,5,6,7,8,9], o, o))
    },
    
    { "provides a 1 for win, -1 for loss, and 0 for tie",
      ?assertEqual(
        0, computer:score_board([x,o,x,x,o,x,o,x,o], o, o))
    }].

switch_piece_test() ->
  [{ "switches piece",
      ?assertEqual(
        o, computer:switch_piece(x))
    },
    
    { "switches piece",
      ?assertEqual(
        x, computer:switch_piece(o))
    }].

special_case_test() ->
  [{ "returns move to block a fork",
      ?assertEqual(
        2, computer:special_case([
                          x,2,3,
                          4,o,6,
                          7,8,x]))
                    }].

best_square_test() ->
  [
    { "correctly implements minimax to make a move",
      ?assertEqual(
        4, computer:best_square(
          [
            1,x,x,
            4,o,o,
            7,8,9
          ], o))
    },
    
    { "correctly implements minimax to make a move",
      ?assertEqual(
        2, computer:best_square(
          [
            x,2,3,
            4,o,6,
            7,8,x
          ], o))
    },
    
    { "correctly implements minimax to make a move",
      ?assertEqual(
        2, computer:best_square(
          [
            1,2,3,
            4,x,6,
            7,x,o
          ], o))
    },
    
    { "correctly implements minimax to make a move",
      ?assertEqual(
        3, computer:best_square(
          [
            x,x,3,
            4,o,6,
            7,o,x
          ], x))
    },
    
    { "correctly implements minimax to make a move",
      ?assertEqual(
        3, computer:best_square(
          [
            x,x,3,
            4,5,6,
            7,8,o
          ], o))
    },
    
    { "correctly implements minimax to make a move",
      ?assertEqual(
        1, computer:best_square(
          [
            1,x,x,
            x,o,o,
            7,o,x
          ], o))
    }].

