

generate_equation(List, Equation) :-
    non_negative_integers(List),
    equation_split(List, LeftNumbers, RightNumbers),
    expression(LeftNumbers, LeftExpression),
    expression(RightNumbers, RightExpression),
    expression_value(LeftExpression, Value),
    expression_value(RightExpression, Value),
    expression_string(LeftExpression, LeftString),
    expression_string(RightExpression, RightString),
    string_concat(LeftString, "=", PartialString),
    string_concat(PartialString, RightString, Equation).

non_negative_integers([]).
non_negative_integers([Number | Numbers]) :-
    integer(Number),
    Number >= 0,
    non_negative_integers(Numbers).

expression([Number], number(Number)).
expression(Numbers, expr(Operator, LeftExpression, RightExpression)) :-
    equation_split(Numbers, LeftNumbers, RightNumbers),
    expression(LeftNumbers, LeftExpression),
    expression(RightNumbers, RightExpression),
    operator(Operator).

operator(add).
operator(subtract).
operator(multiply).
operator(divide).

expression_value(number(Number), Number).
expression_value(expr(add, LeftExpression, RightExpression), Value) :-
    expression_value(LeftExpression, LeftValue),
    expression_value(RightExpression, RightValue),
    Value is LeftValue + RightValue.
expression_value(expr(subtract, LeftExpression, RightExpression), Value) :-
    expression_value(LeftExpression, LeftValue),
    expression_value(RightExpression, RightValue),
    Value is LeftValue - RightValue.
expression_value(expr(multiply, LeftExpression, RightExpression), Value) :-
    expression_value(LeftExpression, LeftValue),
    expression_value(RightExpression, RightValue),
    Value is LeftValue * RightValue.
expression_value(expr(divide, LeftExpression, RightExpression), Value) :-
    expression_value(LeftExpression, LeftValue),
    expression_value(RightExpression, RightValue),
    RightValue =\= 0,
    0 =:= LeftValue mod RightValue,
    Value is LeftValue // RightValue.

expression_string(number(Number), String) :-
    number_string(Number, String).
expression_string(expr(Operator, LeftExpression, RightExpression), String) :-
    operand_string(left, Operator, LeftExpression, LeftString),
    operand_string(right, Operator, RightExpression, RightString),
    operator_string(Operator, OperatorString),
    string_concat(LeftString, OperatorString, PartialString),
    string_concat(PartialString, RightString, String).

operand_string(_, _, number(Number), String) :-
    number_string(Number, String).
operand_string(Position, ParentOperator,
               expr(ChildOperator, LeftExpression, RightExpression), String) :-
    expression_string(expr(ChildOperator, LeftExpression, RightExpression), InnerString),
    operand_parentheses(Position, ChildOperator, ParentOperator, InnerString, String).

operand_parentheses(left, ChildOperator, ParentOperator, InnerString, String) :-
    operator_precedence(ChildOperator, ChildPrecedence),
    operator_precedence(ParentOperator, ParentPrecedence),
    ChildPrecedence < ParentPrecedence,
    string_concat("(", InnerString, WithOpeningParenthesis),
    string_concat(WithOpeningParenthesis, ")", String).
operand_parentheses(right, ChildOperator, ParentOperator, InnerString, String) :-
    operator_precedence(ChildOperator, ChildPrecedence),
    operator_precedence(ParentOperator, ParentPrecedence),
    ChildPrecedence =< ParentPrecedence,
    string_concat("(", InnerString, WithOpeningParenthesis),
    string_concat(WithOpeningParenthesis, ")", String).
operand_parentheses(left, ChildOperator, ParentOperator, String, String) :-
    operator_precedence(ChildOperator, ChildPrecedence),
    operator_precedence(ParentOperator, ParentPrecedence),
    ChildPrecedence >= ParentPrecedence.
operand_parentheses(right, ChildOperator, ParentOperator, String, String) :-
    operator_precedence(ChildOperator, ChildPrecedence),
    operator_precedence(ParentOperator, ParentPrecedence),
    ChildPrecedence > ParentPrecedence.

operator_precedence(add, 1).
operator_precedence(subtract, 1).
operator_precedence(multiply, 2).
operator_precedence(divide, 2).

operator_string(add, "+").
operator_string(subtract, "-").
operator_string(multiply, "*").
operator_string(divide, "/").

equation_split([Number | Numbers], [Number], Numbers) :-
    Numbers = [_ | _].
equation_split([Number | Numbers], [Number | Left], Right) :-
    equation_split(Numbers, Left, Right).
