:- discontiguous is_male/1, is_female/1, is_parent_of/2.
%% # facts
is_male(john).
is_female(jane).
is_parent_of(john, sam).
is_parent_of(jane,sam).
%% # is_parent_of(PARENT,CHILD ).

is_male(sam).
%% # (1 parent in common)
is_male(morris).
is_female(ciara).
is_parent_of(jane, morris).
is_parent_of(jane, ciara).

%% # (2 parents in common) kevin, alberto, scarlett
is_male(alberto).
is_female(scarlett).
is_parent_of(jane, alberto).
is_parent_of(jane, scarlett).
is_parent_of(john, alberto).
is_parent_of(john, scarlett).

%% # uncle
is_male(youssef).
is_female(leia).
%% # cousin
is_male(byron).
is_female(minnie).
is_parent_of(youssef, byron).
is_parent_of(youssef, minnie).
is_parent_of(leia, byron).
is_parent_of(leia, minnie).

%% # grandparents
is_male(abid).
is_female(amal).
is_parent_of(abid, john).
is_parent_of(amal, jane).

%% #greatgrandparents
is_male(ahmad).
is_female(zaynah).
is_parent_of(ahmad, abid).
is_parent_of(zaynah, amal).

%% 

%% # rules
%% # defines parents
%% # (1 parent in common) morris, dylan, ciara

mother(MOTHER, CHILD) :- is_female(MOTHER), is_parent_of(MOTHER, CHILD).
father(FATHER, CHILD) :- is_male(FATHER), is_parent_of(FATHER, CHILD).

sibling1(NAME1, NAME2) :- is_parent_of(Par, NAME1), is_parent_of(Par, NAME2), NAME1 \= NAME2.
brother1(NAME1, NAME2) :- is_male(NAME1), sibling1(NAME1, NAME2).
sister1(NAME1, NAME2) :- is_female(NAME1), sibling1(NAME1, NAME2).

%% # (2 parents in common) kevin, alberto, scarlett
sibling2(NAME1, NAME2) :- is_parent_of(Par, NAME1), is_parent_of(Par, NAME2), NAME1 \= NAME2.
brother2(NAME1, NAME2) :- is_male(NAME1), sibling2(NAME1, NAME2). 
sister2(NAME1, NAME2) :- is_female(NAME1), sibling2(NAME1, NAME2). 

uncle(UNCLE, CHILDNAME) :- is_parent_of(Uncle, CHILDNAME), brother1(Uncle, UNCLE).

aunt(AUNT, CHILDNAME) :- is_parent_of(Aunt, CHILDNAME), sister1(Aunt, AUNT), !.

cousin(NAME1, NAME2) :- uncle(Uncle, NAME1), father(Uncle, NAME2).
cousin(NAME1, NAME2) :- aunt(Aunt, NAME1), mother(Aunt, NAME2).

grandparent(GRANDPARENT, GRANDCHILD) :- is_parent_of(GRANDPARENT, somefamily), is_parent_of(somefamily, GRANDCHILD).
grandfather(GRANDFATHER, GRANDCHILD) :- is_male(GRANDFATHER), grandparent(GRANDFATHER, GRANDCHILD).
grandmother(GRANDMOTHER, GRANDCHILD) :- is_female(GRANDMOTHER), grandparent(GRANDMOTHER, GRANDCHILD).

grandchild(GRANDCHILD, GRANDPARENT) :- grandparent(GRANDPARENT, GRANDCHILD).

greatgrandparent(GREATGRANDPARENT, GREATGRANDCHILD) :- is_parent_of(GREATGRANDPARENT, somefamily), is_parent_of(somefamily, GREATGRANDCHILD).
ancestor(ANCESTOR, CHILDNAME) :- is_parent_of(ANCESTOR, CHILDNAME).
