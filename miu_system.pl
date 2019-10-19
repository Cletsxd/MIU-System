% string_to_code/2. De caracter a código ASCII y viceversa.
string_to_code("M", 77).
string_to_code("I", 73).
string_to_code("U", 85).

%%%%%%%%%%%%%%%%%% MAIN (CHECK W/RULES) %%%%%%%%%%%%%%%%%%
% check_string_main/3. check_string_main(+Axiom, -Bit, -Return).
% Cambia string (Axiom) a ASCII y guarda en lista CodeAxiom.
% Checa alguna RULE.
% Cambia de ASCII a string (ReturnCodeTheorem).
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

%%%%%%%%%%%%%%%%%% RULE 1 %%%%%%%%%%%%%%%%%%
% check_rule1/3. check_rule1(+CodeAxiom, -Bit, -ReturnCodeTheorem).
% Procesa la RULE 1.
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

%%%%%%%%%%%%%%%%%% RULE 2 %%%%%%%%%%%%%%%%%%
% check_rule2/3. check_rule2(+CodeAxiom, -Bit, -ReturnCodeTheorem).
% Procesa la RULE 2.
% Caso 1: base.
% Salida: Bit = 0. Cuando la RULE 2 es falsa. Es decir, que el primer elemento de CodeAxiom no es 77.
check_rule2(CodeAxiom, 0, []) :-
    get_first_list(CodeAxiom, H),
    \+ string_to_code("M", H).
% Caso 2: recursivo.
% Salida: Bit = 1, ReturnCodeTheorem = código ASCII del resultado de la RULE 2. 
% Si el primer elemento de CodeAxiom es 77.
check_rule2(CodeAxiom, 1, ReturnCodeTheorem) :-
    get_first_list(CodeAxiom, H),
    string_to_code("M", H),
    get_rest_list(CodeAxiom, Rest),
    create_rule2(CodeAxiom, Rest, ReturnCodeTheorem).

% get_first_list/2. get_first_list(+String, -Head).
% Salida: regresa el primer elemento de String.
get_first_list([H | _], H).

% get_rest_list/2. get_rest_list(+String, -Rest).
% Salida: regresa el resto de la lista String.
get_rest_list([_ | T], T).

% create_rule2/3. create_rule2(+CodeAxiom, +RestCodeAxiom, -ReturnCodeTheorem).
% Crea el resultado de RULE 2.
% Caso 1: base. Cuando CodeAxiom y RestCodeAxiom son vacías.
create_rule2([], [], []).
% Caso 2: recursivo. Cuando CodeAxiom ya no tiene nada que agregar,
% RestCodeAxiom comienza a agregar a ReturnCodeTheorem.
create_rule2([], [H | T], [H | Return]) :-
    create_rule2([], T, Return).
% Caso 3: recursivo. CodeAxiom agrega primero los elementos de su lista a ReturnCodeTheorem.
% Salida: ReturnCodeTheorem = lista de caracteres en ASCII del resultado de la RULE 2.
create_rule2([H | T], Rest, [H | Return]) :-
    create_rule2(T, Rest, Return).