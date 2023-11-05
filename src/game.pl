/* -*- Mode:Prolog; coding:iso-8859-1; indent-tabs-mode:nil; prolog-indent-width:8; prolog-paren-indent:4; tab-width:8; -*- */
piece_percentage(36).


start_game(P1, P2) :-
    write('What is your desired board size? Default is 9.'), nl,
    read(Size),
    initialize_board(Size,Board),
    get_board_length(Board, Total),
    piece_percentage(Percetage),
    HalfPieceCount is (Total*Percetage) // 200,
    display_game(Board,Size),
    state_switch_forward,
    placement_phase_loop(Board,Size, HalfPieceCount).
    %movement_phase_loop.


%Placement Phase
placement_phase_loop(_, _, 0).
placement_phase_loop(Board,Size, N) :-
    write('Missing '), write(N*2), write(' pieces on the board.'),
    current_player(Player),
    (Player == black -> write('Black ') ; write('White ')),
    write('player, what is the color of the piece you want to place?'),
    nl,
    read(Color),
    manage_color_input(Board,Size, N, Color),
    coordenates_input(X, Y),
    place_piece(X,Y,Board,Size,Color,NewBoard),
    display_game(NewBoard, Size),
    (Color == w -> NewColor = b; NewColor = w),
    (NewColor == b ->
        write('Now you\'re placing a piece of black colour');
        write('Now you\'re placing a piece of white colour')), nl,
    (Player == black -> write('Black ') ; write('White ')),
    coordenates_input(X1, Y1),
    place_piece(X1,Y1,NewBoard,Size,NewColor,LastBoard),
    display_game(LastBoard, Size),
    player_switcher,
    N1 is N - 1,
    placement_phase_loop(LastBoard,Size, N1).
    
manage_color_input(Board,Size, _,'b') :-
    write('Black it is!'), nl.

manage_color_input(Board,Size, _,'w') :-
    write('White it is!'), nl.

manage_color_input(Board,Size, N, _) :-
    write('Invalid color!'), nl,
    write('Please choose between "b" and "w".'), nl,
    placement_phase_loop(Board,Size, N),
    !.

coordenates_input(X, Y) :-
        write('Player, where would you like to place your piece?'), nl,
        write('Row:'), read(X), nl,
        write('Column:'), read(Y), nl.
%Movement Phase
/*movement_phase_loop :-
    state_switch_forward,
    display_game(Board,Size),
    move_piece(X,Y,Board,Size,Player,NewBoard)*/
