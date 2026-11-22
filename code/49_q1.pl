clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Dept \= research,
    Name \= 'Dana'.

clue(2, [p('Alex', Dept, Lang, _), _, _, _]) :-
    Dept \= development,
    Lang \= 'c++'.

clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

clue(4, [_, p('Ben', Dept, _, web), _, _]) :-
    Dept \= testing.

clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

clue(6, [_, _, p('Carla', Dept, _, Project), _]) :-
    Project \= embedded,
    Dept \= development.

clue(7, [_, _, _, p('Dana', Dept, Lang, _)]) :-
    Lang \= java,
    (Dept = research ; Dept = testing).

clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \= javascript.
