-module(board).
-compile(export_all).

place_piece(Square, Piece, Board) ->
  H = lists:sublist(Board, Square - 1),
  T = lists:nthtail(Square, Board),
  H ++ [Piece] ++ T.

undo_place_piece(Square, Board) ->
  H = lists:sublist(Board, Square -1),
  T = lists:nthtail(Square, Board),
  H ++ [Square] ++ T.

combo_winner(Row) -> 
  Empty = board_open(Row),
  if 
    Empty      -> false;
    not Empty  -> 
      [H|T] = Row,
      combo_winner(H,T)      
  end.

combo_winner(_,[]) ->
  true;
combo_winner(Head, Tail) ->
  [H|T] = Tail,
  if 
    Head =/= H -> false;
    Head =:= H -> combo_winner(H,T)
  end.

winner(Board) ->
  Combos = gather_combos(Board),
  check_combos(Combos).

open_squares(Board) ->
  Board -- [x,x,x,x,x,o,o,o,o,o].

board_open(Board) ->
  Pred = fun(X) -> is_integer(X) end,
  lists:any(Pred, Board).

square_open(Square, Board) ->
  Value = lists:nth(Square, Board),
  is_integer(Value).

game_over(Board) ->
  Combos = gather_combos(Board),
  case check_combos(Combos) of
    x -> true;
    o -> true;
    false -> not board_open(Board)
  end.

gather_combos(Board) ->
  gather_rows(Board) ++ gather_columns(Board) ++ gather_diagonals(Board).

gather_rows(Board) -> lists:reverse(gather_rows(Board,[])).

gather_rows([], Gathered) -> Gathered;
gather_rows(Rest, Gathered) ->
  gather_rows(lists:nthtail(3,Rest), [lists:sublist(Rest, 3)|Gathered]).

gather_columns(Board) ->
  [first_column(Board)] ++ [second_column(Board)] ++ [third_column(Board)].
  
check_combos(Combos) -> check_combos(Combos, false).

check_combos([], Winner) -> Winner;
check_combos([H|T], Winner) ->
  case combo_winner(H) of
    true  -> check_combos([], lists:nth(1, H));
    false -> check_combos(T, Winner)
  end.

first_column(Board) -> lists:flatten(lists:reverse(first_column(Board,[]))).

first_column([], Gathered) -> Gathered;
first_column(Rest, Gathered) ->
  first_column(lists:nthtail(3,Rest), [lists:nth(1, Rest)|Gathered]).

second_column(Board) -> lists:flatten(lists:reverse(second_column(Board,[]))).

second_column([], Gathered) -> Gathered;
second_column(Rest, Gathered) ->
  second_column(lists:nthtail(3,Rest), [lists:nth(2, Rest)|Gathered]).

third_column(Board) -> lists:flatten(lists:reverse(third_column(Board,[]))).

third_column([], Gathered) -> Gathered;
third_column(Rest, Gathered) ->
  third_column(lists:nthtail(3,Rest), [lists:nth(3, Rest)|Gathered]).

diagonal_down(Board) -> 
  [lists:nth(1, Board)] ++ [lists:nth(5, Board)] ++ [lists:nth(9, Board)].

diagonal_up(Board) ->
  [lists:nth(7, Board)] ++ [lists:nth(5, Board)] ++ [lists:nth(3, Board)].

gather_diagonals(Board) ->
  [diagonal_down(Board)] ++ [diagonal_up(Board)].

%%diagonal(Board) -> lists:flatten(lists:reverse(diagonal(Board,[]))).
%%
%%diagonal([], Gathered) -> Gathered;
%%diagonal(Rest, Gathered) ->
%%  diagonal(lists:nthtail(4,Rest), [lists:nth(1, Rest)|Gathered]).
