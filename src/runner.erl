-module(runner).
-compile(export_all).

play_game() ->
  Players = configuration:configure_game(),
  game_loop(false, board:make_board(9), Players).

game_loop(GameOver, Board, Players) ->
  case GameOver of
    true ->
      game_over(Board);
    false ->
      next_move(Board, Players)
  end.

take_turn(Board, Players) ->
  Turn = game_rules:get_turn(Board),
  PlayerTuple = get_player(Players, Turn),
  case PlayerTuple of
    {human, Piece} = PlayerTuple -> human:take_turn(Board, Piece);
    {computer, Piece} = PlayerTuple -> computer:take_turn(Board, Piece)
  end.

game_over(Board) ->
  console_io:display(console_io:format_board(Board)),
  case game_rules:winner(Board) of
    x -> console_io:x_wins();
    o -> console_io:o_wins()
  end.

next_move(Board, Players) ->
  console_io:display_board(Board),
  console_io:prompt_move(),
  NewBoard = take_turn(Board, Players),
  GameStatus = game_rules:game_over(NewBoard),
  game_loop(GameStatus, NewBoard, Players).

get_player(Players, Turn) ->
  lists:nth(Turn, Players).

player_type(PlayerTuple) ->
  {Type,_} = PlayerTuple,
  Type.
