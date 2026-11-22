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

% CLUE 9: The friend who prefers the AI project works in the testing department.
clue(9, Solution) :-
    member(p(_, testing, _, 'AI'), Solution).

candidate_solution([p('Alex', AlexDept, AlexLang, AlexProject),
                    p('Ben', BenDept, BenLang, BenProject),
                    p('Carla', CarlaDept, CarlaLang, CarlaProject),
                    p('Dana', DanaDept, DanaLang, DanaProject)]) :-
    permutation([research, development, design, testing],
                [AlexDept, BenDept, CarlaDept, DanaDept]),
    permutation([python, java, 'c++', javascript],
                [AlexLang, BenLang, CarlaLang, DanaLang]),
    permutation(['AI', web, embedded, data],
                [AlexProject, BenProject, CarlaProject, DanaProject]).

active_clues_hold([], _).
active_clues_hold([N | Rest], Solution) :-
    clue(N, Solution),
    active_clues_hold(Rest, Solution).

count_solutions(Active, N) :-
    findall(Solution,
            ( candidate_solution(Solution),
              active_clues_hold(Active, Solution)
            ),
            Solutions),
    length(Solutions, N).

main :-
    candidate_solution(Solution),
    active_clues_hold([1, 2, 3, 4, 5, 6, 7, 8], Solution),
    Solution = [p('Alex', AlexDept, AlexLang, AlexProject),
                p('Ben', BenDept, BenLang, BenProject),
                p('Carla', CarlaDept, CarlaLang, CarlaProject),
                p('Dana', DanaDept, DanaLang, DanaProject)],
    format('Alex = [~w, ~w, ~w]~n', [AlexDept, AlexLang, AlexProject]),
    format('Ben = [~w, ~w, ~w]~n', [BenDept, BenLang, BenProject]),
    format('Carla = [~w, ~w, ~w]~n', [CarlaDept, CarlaLang, CarlaProject]),
    format('Dana = [~w, ~w, ~w]~n', [DanaDept, DanaLang, DanaProject]).
