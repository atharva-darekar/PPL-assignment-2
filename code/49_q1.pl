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

main :-
    Solution = [p('Alex', AlexDept, AlexLang, AlexProject),
                p('Ben', BenDept, BenLang, BenProject),
                p('Carla', CarlaDept, CarlaLang, CarlaProject),
                p('Dana', DanaDept, DanaLang, DanaProject)],
    permutation([research, development, design, testing],
                [AlexDept, BenDept, CarlaDept, DanaDept]),
    permutation([python, java, 'c++', javascript],
                [AlexLang, BenLang, CarlaLang, DanaLang]),
    permutation(['AI', web, embedded, data],
                [AlexProject, BenProject, CarlaProject, DanaProject]),
    clue(1, Solution),
    clue(2, Solution),
    clue(3, Solution),
    clue(4, Solution),
    clue(5, Solution),
    clue(6, Solution),
    clue(7, Solution),
    clue(8, Solution),
    format('Alex = [~w, ~w, ~w]~n', [AlexDept, AlexLang, AlexProject]),
    format('Ben = [~w, ~w, ~w]~n', [BenDept, BenLang, BenProject]),
    format('Carla = [~w, ~w, ~w]~n', [CarlaDept, CarlaLang, CarlaProject]),
    format('Dana = [~w, ~w, ~w]~n', [DanaDept, DanaLang, DanaProject]).
