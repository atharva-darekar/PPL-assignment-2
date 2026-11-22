:- consult('../code/49_q1.pl').

run_p1_tests :-
    test_all_eight_clues,
    test_repaired_puzzle,
    test_repaired_solution,
    test_no_active_clues,
    test_single_active_clue,
    test_clue_nine_rejects_other_solutions.

test_all_eight_clues :-
    count_solutions([1, 2, 3, 4, 5, 6, 7, 8], 3).

test_repaired_puzzle :-
    count_solutions([1, 2, 3, 4, 5, 6, 7, 8, 9], 1).

test_repaired_solution :-
    findall(Solution,
            ( candidate_solution(Solution),
              active_clues_hold([1, 2, 3, 4, 5, 6, 7, 8, 9], Solution)
            ),
            [[p('Alex', design, java, embedded),
              p('Ben', development, javascript, web),
              p('Carla', testing, python, 'AI'),
              p('Dana', research, 'c++', data)]]).

test_no_active_clues :-
    count_solutions([], 13824).

test_single_active_clue :-
    count_solutions([9], 3456).

test_clue_nine_rejects_other_solutions :-
    \+ clue(9, [p('Alex', design, java, 'AI'),
                 p('Ben', development, javascript, web),
                 p('Carla', research, 'c++', data),
                 p('Dana', testing, python, embedded)]),
    \+ clue(9, [p('Alex', testing, python, embedded),
                 p('Ben', development, javascript, web),
                 p('Carla', design, java, 'AI'),
                 p('Dana', research, 'c++', data)]).
