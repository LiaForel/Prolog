%% facts
% male members
is_male(baha).
is_male(omurbek).
is_male(belek).
is_male(chynaly).
is_male(daniel).
is_male(turaly).
is_male(kurmant).

%female members
is_female(marsia).
is_female(bakulia).
is_female(sada).
is_female(diana).
is_female(nurpasha).
is_female(aidai).
is_female(batma).
is_female(nazik).
is_female(nigina).

%% is_parent_of(PARENT,CHILD).
is_parent_of(baha, bakulia).
is_parent_of(baha,nigina).
is_parent_of(marsia, bakulia).
is_parent_of(marsia, nigina).
is_parent_of(omurbek, nazik).
is_parent_of(omurbek, belek).
is_parent_of(marsia, nazik).
is_parent_of(marsia, belek).
is_parent_of(chynaly, daniel).
is_parent_of(chynaly, diana).
is_parent_of(sada, daniel).
is_parent_of(sada, diana).
is_parent_of(turaly, marsia).
is_parent_of(turaly, chynaly).
is_parent_of(nurpasha, marsia).
is_parent_of(nurpasha, chynaly).
is_parent_of(kurmant, turaly).
is_parent_of(kurmant, batma).
is_parent_of(aidai, turaly).
is_parent_of(aidai, batma).

%Rules
%define parents
mother(MOTHER, CHILD) :- is_female(MOTHER), is_parent_of(MOTHER, CHILD).
father(FATHER, CHILD) :- is_male(FATHER), is_parent_of(FATHER, CHILD).
parent(PARENT, CHILD) :- father(PARENT, CHILD); mother(PARENT, CHILD).

% (1 parents in common) 
sibling1(NAME1, NAME2) :- 
    NAME1 \= NAME2,
    father(F, NAME1), 
    father(F, NAME2),
    mother(M1, NAME1),
    mother(M2, NAME2),
    M1 \= M2; 
    father(F1, NAME1), 
    father(F2, NAME2),
    mother(M, NAME1), 
    mother(M, NAME2),
    F1 \= F2, 
    NAME1 \= NAME2.
brother1(NAME1, NAME2) :- is_male(NAME1), sibling1(NAME1, NAME2).
sister1(NAME1, NAME2) :- is_female(NAME1), sibling1(NAME1, NAME2).

% (2 parents in common) 
sibling2(NAME1, NAME2) :- father(F, NAME1), father(F, NAME2), mother(M, NAME1), mother(M, NAME2), NAME1 \= NAME2.
brother2(NAME1, NAME2) :- is_male(NAME1), sibling2(NAME1, NAME2). 
sister2(NAME1, NAME2) :- is_female(NAME1), sibling2(NAME1, NAME2). 

% (uncle, aunt cousins) 
uncle(UNCLE, CHILDNAME) :- brother2(UNCLE, Par), parent(Par, CHILDNAME); brother1(UNCLE, Par), parent(Par, CHILDNAME).
aunt(AUNT, CHILDNAME) :- sister2(AUNT, Par), parent(Par, CHILDNAME); sister1(AUNT, Par), parent(Par, CHILDNAME).
cousin(NAME1, NAME2) :- uncle(Uncle, NAME1), father(Uncle, NAME2); aunt(Aunt, NAME1), mother(Aunt, NAME2).

% (third generation) 
grandparent(GRANDPARENT, GRANDCHILD) :- is_parent_of(GRANDPARENT, Par), is_parent_of(Par, GRANDCHILD).
grandfather(GRANDFATHER, GRANDCHILD) :- is_male(GRANDFATHER), grandparent(GRANDFATHER, GRANDCHILD).
grandmother(GRANDMOTHER, GRANDCHILD) :- is_female(GRANDMOTHER), grandparent(GRANDMOTHER, GRANDCHILD).
grandchild(GRANDCHILD, GRANDPARENT) :- grandparent(GRANDPARENT, GRANDCHILD).
greatgrandparent(GREATGRANDPARENT, GREATGRANDCHILD) :- grandparent(GREATGRANDPARENT, Par), is_parent_of(Par, GREATGRANDCHILD).

% (ancestors and descendants) 
ancestor(ANCESTOR, CHILDNAME) :- is_parent_of(ANCESTOR, CHILDNAME).
ancestor(ANCESTOR, CHILDNAME) :- is_parent_of(Par, CHILDNAME), ancestor(ANCESTOR, Par).
