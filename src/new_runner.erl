-module(new_runner).
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
