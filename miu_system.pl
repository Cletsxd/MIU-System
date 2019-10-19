% string_to_code/2. De caracter a código ASCII y viceversa.
string_to_code("M", 77).
string_to_code("I", 73).
string_to_code("U", 85).

% check_string_main/3. check_string_main(+Axiom, -Bit, -Return).
% Return es la respuesta de un teorema al axioma Axiom. Bit es un bit de control (1 - true, 0 - false).
check_string_main(Axiom, Bit, Return) :-
    check_code_string(Axiom, CodeAxiom),
    check_rule2(CodeAxiom, Bit, ReturnCodeTheorem),
    check_string_code(Return, ReturnCodeTheorem).

% check_code_string/2. check_code_string(+String, -Code).
% Salida: Code = código ASCII de String.
check_code_string(String, Code) :-
    string_codes(String, Code).

% check_string_code/2. check_string_code(-String, +Code).
% Toma una lista en código ASCII en Code y lo pasa a una cadena de caracteres String.
check_string_code(String, Code) :-
    string_codes(String, Code).

% check_rule1/3. check_rule1(+CodeAxiom, 0, []).
% Toma un axioma en código ASCII en la lista CodeAxiom.
% Caso 1: base. 
% Salida: Bit = 0 si el último elemento de CodeAxiom no es 73 (checar string_to_code/2).
check_rule1(CodeAxiom, 0, []) :-
    get_last_list(CodeAxiom, Last),
    \+ string_to_code("I", Last).
% Caso 2: recursivo. Si el último elemento de CodeAxiom es 73 (checar string_to_code/2).
% Salida: Bit = 1, y ReturnCodeTheorem = "xIU".
check_rule1(CodeAxiom, 1, ReturnCodeTheorem) :-
    get_last_list(CodeAxiom, Last),
    string_to_code("I", Last),
    create_rule1(CodeAxiom, ReturnCodeTheorem).

% get_last_list/2. get_last_list(+List, -Last).
% Toma el valor último Last de la lista List.
% Salida: último elemento de List.
get_last_list([T | []], T) :- !.
get_last_list([_ | T], Last) :-
    get_last_list(T, Last).

% create_rule1/2. create_rule1(+CodeAxiom, -ReturnCodeTheorem).
% Regresa la respuesta de una regla/teorema.
% Salida: ej. ReturnCodeTheorem = [73, 73, 73, 85].
create_rule1([T | []], [T | [85]]).
create_rule1([H | T], [H | Return]) :-
    create_rule1(T, Return).

check_rule2(CodeAxiom, 0, []) :-
    get_first_list(CodeAxiom, H),
    \+ string_to_code("M", H).

check_rule2(CodeAxiom, 1, ReturnCodeTheorem) :-
    get_first_list(CodeAxiom, H),
    string_to_code("M", H),
    get_rest_list(CodeAxiom, Rest),
    create_rule2(CodeAxiom, Rest, ReturnCodeTheorem).

get_first_list([H | _], H).

get_rest_list([_ | T], T).

create_rule2([], [], []).
create_rule2([], [H | T], [H | Return]) :-
    create_rule2([], T, Return).
create_rule2([H | T], Rest, [H | Return]) :-
    create_rule2(T, Rest, Return).