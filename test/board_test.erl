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

undo_place_piece_test() ->
  [{ "removes a piece placed on board",
      ?assertEqual(
        [1,2,3,4,5,6,7,8,9],
        board:undo_place_piece(1, [x,2,3,4,5,6,7,8,9]))
    }].

winner_test() ->
  [{ "checks for winner on board",
      ?assertEqual(
        x, board:winner([1,2,3,x,x,x,7,8,9]))
      }].

combo_winner_test() ->
  [{ "checks for combo_winner in a row",
      ?assertEqual(
        true, board:combo_winner([x,x,x]))
    },
    
   { "checks for combo_winner in a row",
      ?assertEqual(
        true, board:combo_winner([o,o,o]))
    },
    
   { "checks for combo_winner in a row",
      ?assertEqual(
        false, board:combo_winner([o,2,o]))
    },
    
   { "checks for combo_winner in a row",
      ?assertEqual(
        false, board:combo_winner([x,o,o]))
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

game_over_test() ->
  [{ "returns true if tie game",
      ?assertEqual(
        game_over, board:game_over([o,x,o,x,o,x,x,o,x]))
    },
    
    { "returns true if x wins",
      ?assertEqual(
        game_over, board:game_over([x,x,x,4,5,6,7,8,9]))
    },
    
    { "returns false if game still playable",
      ?assertEqual(
        false, board:game_over([1,x,o,x,o,x,x,o,x]))
    }].

gather_rows_test() ->
  [{ "returns list of rows from board",
      ?assertEqual(
        [[1,2,3],[4,5,6],[7,8,9]], board:gather_rows([1,2,3,4,5,6,7,8,9]))
    }].

gather_columns_test() ->
  [{ "returns list of rows from board",
      ?assertEqual(
        [[1,4,7],[2,5,8],[3,6,9]], board:gather_columns([1,2,3,4,5,6,7,8,9]))
    }].

first_column_test() ->
  [{ "returns list of columns from board",
      ?assertEqual(
        [1,4,7], board:first_column([1,2,3,4,5,6,7,8,9]))
    }].

second_column_test() ->
  [{ "returns list of columns from board",
      ?assertEqual(
        [2,5,8], board:second_column([1,2,3,4,5,6,7,8,9]))
    }].

third_column_test() ->
  [{ "returns list of columns from board",
      ?assertEqual(
        [3,6,9], board:third_column([1,2,3,4,5,6,7,8,9]))
    }].

diagonal_down_test() ->
  [{ "returns list of diagonal squares from left to right",
      ?assertEqual(
        [1,5,9], board:diagonal_down([1,2,3,4,5,6,7,8,9]))
    }].

diagonal_up_test() ->
  [{ "returns list of diagonal squares from right to left",
      ?assertEqual(
        [7,5,3], board:diagonal_up([1,2,3,4,5,6,7,8,9]))
    }].

gather_diagonals_test() ->
  [{ "returns combined list of diagonals",
      ?assertEqual(
        [[1,5,9],[7,5,3]], board:gather_diagonals([1,2,3,4,5,6,7,8,9]))
    }].

gather_combos_test() ->
  [{ "gathers all 8 combinations",
      ?assertEqual(
        [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[7,5,3]], board:gather_combos([1,2,3,4,5,6,7,8,9]))
    }].

check_combos_test() ->
  [{ "returns winning piece",
      ?assertEqual(
        x, board:check_combos([[x,x,x],[4,5,6],[7,8,9]]))
    },

    { "returns winning piece",
      ?assertEqual(
        o, board:check_combos([[1,2,3],[o,o,o],[7,8,9]]))
    },
    
    { "returns false if no winner is found",
      ?assertEqual(
        false, board:check_combos([[x,2,x],[4,5,6],[7,8,9]]))
    }].

%%diagonal_test() ->
%%  [{ "returns list of diagonal from top left to bottom right",
%%      ?assertEqual(
%%        [1,5,9], board:diagonal([1,2,3,4,5,6,7,8,9]))
%%      }].
