% The 8-Queens Problem
% ■ Chess background:
% – Playedonan8-by-8grid
% – Queen can move any number of spaces vertically, horizontally or diagonally
% – Two queens are in check if they are in the same row, column or diagonal, so that one could move to the other’s square
% ■ The problem: place 8 queens on an empty chess board so that no queen is in check

/*
  eightqueens(X) succeeds if X is a legal
  placement of eight queens, listed in order
  of their X coordinates.
*/

eightqueens(X) :-  X = [1/_,2/_,3/_,4/_,5/_,6/_,7/_,8/_], legal(X). nocheck(_, []).
nocheck(X/Y, [X1/Y1 | Rest]) :- Y =\= Y1, abs(Y1-Y) =\= abs(X1-X), nocheck(X/Y, Rest).  legal([]).
legal([X/Y | Rest]) :-  legal(Rest), member(Y,[1,2,3,4,5,6,7,8]),nocheck(X/Y, Rest).

% member(X,[1,2,3,4,5,6,7,8]), assume X in range member(Y,[1,2,3,4,5,6,7,8]),
% nocheck(X/Y, Rest).;;
