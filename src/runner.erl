-module(runner).
-compile(export_all).

get_player(Players, Turn) ->
  lists:nth(Turn, Players).

player_type(PlayerTuple) ->
  {Type,_} = PlayerTuple,
  Type.

take_turn(Board, Players) ->
  Turn = game_rules:get_turn(Board),
  PlayerTuple = get_player(Players, Turn),
  case PlayerTuple of
    {human, Piece} = PlayerTuple -> human:take_turn(Board, Piece);
    {computer, Piece} = PlayerTuple -> computer:take_turn(Board, Piece)
  end.

game_loop(GameOver, Board, Players) ->
  case GameOver of
    true ->
      console_io:display(console_io:format_board(Board)),
      console_io:game_over();
    false ->
      console_io:display_board(Board),
      console_io:prompt_move(),
      NewBoard = take_turn(Board, Players),
      GameStatus = game_rules:game_over(NewBoard),
      game_loop(GameStatus, NewBoard, Players)
  end.

play_game() ->
  game_loop(false, [1,2,3,4,5,6,7,8,9], [{human, x}, {human, o}]).
