-module(game_rules_test).
-include_lib("eunit/include/eunit.hrl").

store_move_test() ->
  [{ "stores a piece on the board",
      ?assertEqual(
        ["piece", 2, 3],
        game_rules:store_move(1, "piece", [1,2,3]))
    }].

undo_store_move_test() ->
  [{ "undoes storing a piece on the board",
      ?assertEqual(
        [1,2,3],
        game_rules:undo_store_move(1, ["piece", 2, 3]))
    }].

square_open_test() ->
  [{ "returns false if space is taken",
      ?assertEqual(
        false, game_rules:square_open(1, ["taken",2,3]))
    },
  
    { "returns true if space is not taken",
      ?assertEqual(
        true, game_rules:square_open(1, [1,2,3]))
    }].

board_open_test() ->
  [{ "returns true if an empty square is on board",
      ?assertEqual(
        true, game_rules:board_open([1,2,3]))
    },
    { "returns false if no empty squares exist",
      ?assertEqual(
        false, game_rules:board_open([x,o,x]))
  }].

game_over_test() ->
  [{ "returns true if game is over",
      ?assertEqual(
        true, game_rules:game_over([x,x,x,4,5,6,7,8,9]))
    }].

winner_test() ->
  [{ "returns winning marker type or false if no winner",
      ?assertEqual(
        x, game_rules:winner([x,x,x,4,5,6,7,8,9]))
    }].

combo_winner_test() ->
  [{ "checks for three in a row",
      ?assertEqual(
        true, game_rules:combo_winner([x,x,x]))
    },
    
    { "checks for three in a row",
      ?assertEqual(
        false, game_rules:combo_winner([x,2,x]))
    }].

gather_combos_test() ->
  [{ "gathers all combinations",
      ?assertEqual(
        [
          [1,2,3],
          [4,5,6],
          [7,8,9],
          [1,4,7],
          [2,5,8],
          [3,6,9],
          [1,5,9],
          [3,5,7]
        ], game_rules:gather_combos([1,2,3,4,5,6,7,8,9]))
    },
    
    { "gathers row combinations",
      ?assertEqual(
        [[1,2,3],[4,5,6],[7,8,9]], game_rules:gather_rows([1,2,3,4,5,6,7,8,9]))
    },

    { "gathers column combinations",
      ?assertEqual(
        [[1,4,7], [2,5,8], [3,6,9]], game_rules:columns([1,2,3,4,5,6,7,8,9]))
    },
  
    { "gathers diagonal combinations",
    ?assertEqual(
      [[1,5,9],[3,5,7]], game_rules:gather_diagonals([1,2,3,4,5,6,7,8,9]))
  }].

diagonal_one_test() ->
  [{ "returns first diagonal",
      ?assertEqual(
        [1,5,9], game_rules:diagonal_one([1,2,3,4,5,6,7,8,9]))
    }].

diagonal_two_test() ->
  [{ "returns second diagonal",
      ?assertEqual(
        [3,5,7], game_rules:diagonal_two([1,2,3,4,5,6,7,8,9]))
    }].

