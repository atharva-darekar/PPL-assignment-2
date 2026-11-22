:- consult('../code/25_q2.pl').

run_p2_tests :-
    test_pdf_all_equations,
    test_pdf_no_solution,
    test_pdf_single_equation,
    test_empty_and_singleton_lists,
    test_zero_values,
    test_repeated_values,
    test_exact_division,
    test_invalid_division_rejected.

test_pdf_all_equations :-
    all_equations([4, 2, 5, 3],
                  ["4*2-5=3", "4*2=5+3", "4-2=5-3", "4/2=5-3",
                   "4=2*(5-3)", "4=2+(5-3)", "4=2+5-3"]),
    count_equations([4, 2, 5, 3], 7).

test_pdf_no_solution :-
    \+ generate_equation([2, 3, 4], _),
    all_equations([2, 3, 4], []),
    count_equations([2, 3, 4], 0).

test_pdf_single_equation :-
    generate_equation([2, 4, 8], "2*4=8"),
    all_equations([2, 4, 8], ["2*4=8"]),
    count_equations([2, 4, 8], 1).

test_empty_and_singleton_lists :-
    \+ generate_equation([], _),
    \+ generate_equation([7], _),
    all_equations([], []),
    all_equations([7], []),
    count_equations([], 0),
    count_equations([7], 0).

test_zero_values :-
    all_equations([0, 0], ["0=0"]),
    count_equations([0, 0], 1).

test_repeated_values :-
    all_equations([1, 1, 1],
                  ["1*1=1", "1/1=1", "1=1*1", "1=1/1"]),
    count_equations([1, 1, 1], 4).

test_exact_division :-
    all_equations([8, 4, 2], Equations),
    member("8/4=2", Equations).

test_invalid_division_rejected :-
    \+ expression_value(expr(divide, number(5), number(2)), _),
    \+ expression_value(expr(divide, number(1), number(0)), _).
