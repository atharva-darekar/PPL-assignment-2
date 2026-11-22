

equation_split([Number | Numbers], [Number], Numbers) :-
    Numbers = [_ | _].
equation_split([Number | Numbers], [Number | Left], Right) :-
    equation_split(Numbers, Left, Right).
