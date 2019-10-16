% The purpose of this homework is to develop skills in the area of PROLOG list processing.
% 1. Write a PROLOG program that investigates family relationships using lists. 
% The facts should be organized as follows:

% - father(Baha)
% - Brother1(Belek)
% - brother2(tilek)
% - maleCousin(Arthur)
% - Uncle(Nurlan)
% - grandson(Platon)
% - grandfather(Turaly)
% - greatgrandfather(kurmant)

% - mother(Marsia)
% - sister1(Nazik)
% - sister2(Nigina)
% - femaleCousin(Ardak)
% - granddaughter(Aliya)
% - Aunt(Valentina)
% - grandmother(Nurpasha)
% - greatgrandmother(Narpasha)

% family([[baha, marsia], 
%        [belek, tilek, nazik, nigina], 
%        [arthur, ardak], 
%        [nurlan, valentina], 
%        [platon, medina], 
%        [turaly, nurpasha],
%        [kurmant, narpasha]]).

malefam([baha, belek, tilek, arthur, nurlan, platon, turaly, kurmant]). 
femalefam([marsia, nazik, nigina, ardak, medina, valentina, nurpasha, narpasha]). 
% family([father, mother], [[brother1, brother2], [sister1, sister2]]).

family(
       [[[sibling1], [brother1, sister1]], [[sibling2], [brother2, sister2]], [cousin]],
       [parent, [father, mother], [uncle, aunt]], 
       [grandparent,[grandfather, grandmother]],
       [greatgrandparent], 
       [ancestor]
      ).

% Write rules that define the following relations:
member(H, [H|_]). % base case
member(H,[_|T]) :- member(H,T). % recursive case for all members in list

% father
father(FATHER, CHILD) :-  
    family([[Sibling,_],[Sibling2,_], [_]],
    [_,[FATHER,_], [_,_]],
    [_,[_,_]],
    [_],
    [_]), 
    (member(CHILD, Sibling); 
    member(CHILD, Sibling2)).

% mother
mother(MOTHER, CHILD) :-  
    family([[Sibling,_],[Sibling2,_], [_]],
    [_,[_,MOTHER], [_,MOTHER]],
    [_,[_,_]],
    [_],
    [_]), 
    (member(CHILD, Sibling); 
    member(CHILD, Sibling2)).

% parent
parent(PARENT, CHILD) :- father(PARENT, CHILD); mother(PARENT, CHILD).

% siblings1
siblings1(Siblings1) :- 
    family([[_,Siblings1],[_,_], [_]],
    [_,[_,_], [_,_]],
    [_,[_,_]],
    [_],
    [_]).

% siblings2
siblings2(Siblings2) :-  
    family([[_,_],[_,Siblings2], [_]],
    [_,[_,_], [_,_]],
    [_,[_,_]],
    [_],
    [_]).

% brothers
brother1(Brother) :- siblings1(Brother).
brother2(Brother) :- siblings2(Brother).

% reverse([siblings1], [siblings1]).
% sisters
sister1(Sister) :- siblings1(Sister).
sister2(Sister) :- siblings2(Sister).

% cousins
cousin(NAME1, NAME2) :- siblings1(NAME1), siblings2(NAME2).

% uncle
% uncle(UNCLE, CHILDNAME) :- is_parent_of(Uncle, CHILDNAME), brother1(Uncle, UNCLE).
uncle(UNCLE, CHILDNAME) :- parent(Uncle, CHILDNAME), siblings1(Uncle, UNCLE).

% male(M) :- malefam(MALES), member(M, MALES).
% member(H,[H|T]) :- member(H,T). % recursive case for first member of the list
% male(M) :- family([M,_],_).
% male(M) :- family(_,[Brothers,_]), member(M,Brothers).
% female(F) :- femalefam(FEMALES), member(F, FEMALES).

% member([H|T]) :- malefam([H|T]), member([T]).
% member([A, B, C, D, H, G, E|T]) :- malefam([A, B, C, D, H, G, E|T]). 
% member([A, B, C, D, H, G, E|T]) :- female([A, B, C, D, H, G, E|T]).


% uncle(UNCLE, CHILDNAME).
% aunt(AUNT, CHILDNAME).
% grandchild(GRANDCHILD, GRANDPARENT).
% granddaughter(GRANDDAUGHTER, GRANDPARENT).
% grandson(GRANDSON, GRANDPARENT).
% greatgrandparent(GREATGRANDPARENT, GREATGRANDCHILD).
% ancestor(ANCESTOR, CHILDNAME).



% father, mother, parent
% siblings1, siblings2
% brother1, brother2
% sister1, sister2
% cousins
% uncle, aunt
% grandchild, grandson, granddaughter
% greatgrandparent
% ancestor

% For each of these rules show an example of its use.




