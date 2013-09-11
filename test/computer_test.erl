-module(computer_test).
-include_lib("eunit/include/eunit.hrl").

score_board_test() ->
  [{ "provides a 1 for win, -1 for loss, and 0 for tie",
      ?assertEqual(
        1, computer:score_board([x,x,x,4,5,6,7,8,9], x))
    },
    
    { "provides a 1 for win, -1 for loss, and 0 for tie",
      ?assertEqual(
        -1, computer:score_board([x,x,x,4,5,6,7,8,9], o))
    },
    
    { "provides a 1 for win, -1 for loss, and 0 for tie",
      ?assertEqual(
        0, computer:score_board([x,o,x,x,o,x,o,x,o], o))
    }].

minimax_test() ->
    [{ "provides a 1 for win, -1 for loss, and 0 for tie",
        ?assertEqual(
          1.0, computer:minimax([x,x,x,4,5,6,7,8,9], x, 1))
      },
      
      { "provides a 1 for win, -1 for loss, and 0 for tie",
        ?assertEqual(
          -1.0, computer:minimax([x,x,x,4,5,6,7,8,9], o, 1))
      },
      
      { "provides a 1 for win, -1 for loss, and 0 for tie",
        ?assertEqual(
          0.0, computer:minimax([x,o,x,x,o,x,o,x,o], o, 1))
      }].
