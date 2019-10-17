% Write a PROLOG program that investigates family relationships using lists. 
% The facts is organized as follows:

malefam([baha, omurbek, belek, chynaly, daniel, turaly, kurmant]). 
femalefam([marsia, bakulia, sada, diana, nurpasha, aidai, batma, nazik, nigina]).

family([baha, marsia, [bakulia, nigina]]).
family([omurbek, marsia, [nazik, belek]]).
family([chynaly, sada, [daniel, diana]]).
family([turaly, nurpasha, [marsia, chynaly]]).
family([kurmant, aidai, [turaly, batma]]).

% Rules that define the following relations:
member(H, [H|_]). % base case
member(H,[_|T]) :- member(H,T). % recursive case for all members in list

male(M) :- malefam(MALES), member(M, MALES).
female(F) :- femalefam(FEMALES), member(F, FEMALES).

father(FATHER, CHILD) :- male(FATHER), family([FATHER,_,L]), member(CHILD, L).
mother(MOTHER, CHILD) :- female(MOTHER), family([_,MOTHER,L]), member(CHILD, L).
parent(PARENT, CHILD) :- father(PARENT, CHILD); mother(PARENT, CHILD).

siblings1(SIB1, SIB2) :- family([D, _, L1]), family([D, _, L2]), member(SIB1, L1), member(SIB2, L2), L1 \= L2;
                         family([_, M, L1]), family([_, M, L2]), member(SIB1, L1), member(SIB2, L2), L1 \= L2.
siblings2(SIB1, SIB2) :- father(F, SIB1), father(F, SIB2), mother(P, SIB1), mother(P, SIB2), SIB1 \= SIB2.

brother1(B, HALFSIB) :- male(B), siblings1(B, HALFSIB).
brother2(B, SIB) :- male(B), siblings2(B, SIB).
sister1(S, HALFSIB) :- female(S), siblings1(S, HALFSIB).
sister2(S, SIB) :- female(S), siblings2(S, SIB).

uncle(UNCLE,CHILD) :- brother2(UNCLE,Par), parent(Par,CHILD); brother1(UNCLE,Par), parent(Par,CHILD).
aunt(AUNT,CHILD) :- sister2(AUNT,Par), parent(Par,CHILD); sister1(AUNT,Par), parent(Par,CHILD).
cousin(COUSIN1, COUSIN2) :- uncle(Uncle, COUSIN1), father(Uncle, COUSIN2); aunt(Aunt, COUSIN1), mother(Aunt, COUSIN2).

grandchild(GRANDCHILD, GRANDPARENT) :- parent(Parent, GRANDCHILD), parent(GRANDPARENT, Parent).
grandson(GRANDSON, GRANDPARENT) :- male(GRANDSON), grandchild(GRANDSON, GRANDPARENT).
granddaughter(GRANDDAUGHTER, GRANDPARENT) :- female(GRANDDAUGHTER), grandchild(GRANDDAUGHTER, GRANDPARENT).
greatgrandparent(GREATGRANDPARENT, GREATGRANDCHILD) :- 
            parent(GREATGRANDPARENT, GrandParent), 
            parent(GrandParent, Parent), 
            parent(Parent, GREATGRANDCHILD).

ancestors(ANCESTORS, DESCENDANT) :- parent(ANCESTORS, DESCENDANT). % base case
ancestors(ANCESTORS, DESCENDANT) :- parent(Parent, DESCENDANT), ancestors(ANCESTORS, Parent). % recursive case for all members in list
