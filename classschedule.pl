%% The web site http://www.sfsu.edu/online/clssch.htm has
%% the class schedule of CS classes for the current semester. Write a
%% PROLOG program "schedule.pro" that includes the following facts:

% teaches(INSTRUCTOR, CLASS).
% freshman(CLASS).
% sophomore(CLASS).
% junior(CLASS).
% senior(CLASS).
% morning(CLASS).
% afternoon(CLASS).
% tth(CLASS).
% mwf(CLASS).

%% class schedule from http://www.sfsu.edu/online/clssch.htm 
teaches(nguyen, csc110).
teaches(tutle, csc210).
teaches(ta, csc220).
teaches(tomasevich, csc230).
teaches(sikder, csc256).
teaches(tomasevich, csc300).
teaches(souza, csc317).
teaches(ta, csc340).
teaches(souza , csc413).
teaches(pinera, csc415).
teaches(wall, csc510).
teaches(pico, csc520).
teaches(dujmovic , csc600).
teaches(costa, csc645).
teaches(costa, csc648).
teaches(parra, csc667).
teaches(costa, csc675).

%% freshman
freshman(csc110).
freshman(csc210).
freshman(csc220).
freshman(csc230).
freshman(csc256).

%% sophomore
sophomore(csc317).
sophomore(csc340).
sophomore(csc300).

%% junior
junior(csc413).
junior(csc415).
junior(csc510).
junior(csc520).

%% senior
senior(csc645).
senior(csc648).
senior(csc600).
senior(csc667).
senior(csc675).

%% morning
morning(csc300).
morning(csc413).
morning(csc340).
morning(csc510).
morning(csc600).

%% afternoon
afternoon(csc413).
afternoon(csc415).
afternoon(csc667).
afternoon(csc675).
afternoon(csc520).

%% tuesday and Thursday
tth(csc300).
tth(csc413).
tth(csc648).
tth(csc340).
tth(csc667).

%% Mon, Wed, Fri
mwf(csc220).
mwf(csc256).
mwf(csc600).
mwf(csc675).
mwf(csc510).

%% Add to these facts the following inference rules

teaches_freshman(INSTRUCTOR) :- teaches(INSTRUCTOR, CLASS), freshman(CLASS).
teaches_sophomore(INSTRUCTOR) :- teaches(INSTRUCTOR, CLASS), sophomore(CLASS).
teaches_junior(INSTRUCTOR) :- teaches(INSTRUCTOR, CLASS), junior(CLASS).
teaches_senior(INSTRUCTOR) :- teaches(INSTRUCTOR, CLASS), senior(CLASS).
teaches_morning(INSTRUCTOR) :- teaches(INSTRUCTOR, CLASS), morning(CLASS).
teaches_afternoon(INSTRUCTOR) :- teaches(INSTRUCTOR, CLASS), afternoon(CLASS).
teaches_whole_day(INSTRUCTOR) :- teaches(INSTRUCTOR, CLASS), morning(CLASS), afternoon(CLASS).
works_mwf(INSTRUCTOR) :- teaches(INSTRUCTOR, CLASS), mwf(CLASS).
works_tth(INSTRUCTOR) :- teaches(INSTRUCTOR, CLASS), tth(CLASS).
teaches_three_classes(INSTRUCTOR) :- teaches(INSTRUCTOR, Class), teaches(INSTRUCTOR, Class1), teaches(INSTRUCTOR, Class2), Class \= Class1, Class\= Class2, Class1 \= Class2, !. 

%% Show the results of your program for each of inference rules.
%% Note: The list of facts must contain enough data to illustrate the above rules. 
%% Such a list may contain a subset of courses that are actually offered by the CS Department.ls
