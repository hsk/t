#!/usr/bin/env swipl --toplevel=halt --stand_alone=true -q
:- style_check(-singleton).
:- set_prolog_flag(double_quotes,codes).
:- initialization(main).
:- op(1200, xfx, [ -- ]).
:- op(910, xfx, [ ⊢ ]).
:- op(900, xfx, [ ⇓, : ]).
:- op(892, xfy, [ then, else ]).
:- op(891, xfy, [ in ]).
:- op(890, fx, [ letrec, let, if ]).
:- op(888, xfy, ::).
:- op(500, yfx, $).

:- set_prolog_flag(report_error,true).
:- set_prolog_flag(unknown,error). 

bool(true). bool(false).

lookup((Γ, X :V ), X : V).
lookup((Γ, X1:V1), X : V) :- X1\==X, lookup(Γ, X : V).

%% evaluation rules

term_expansion(A -- B, B :- A).

integer(I),!
--%------------------------------------ (E-Int)
C ⊢ I ⇓ I.

bool(B),!
--%------------------------------------ (E-Bool)
C ⊢ B ⇓ B.

C ⊢ E1 ⇓ true, C ⊢ E2 ⇓ V
--%------------------------------------ (E-IfTrue)
C ⊢ if E1 then E2 else E3 ⇓ V.

C ⊢ E1 ⇓ false, C ⊢ E3 ⇓ V
--%------------------------------------ (E-IfFalse)
C ⊢ if E1 then E2 else E3 ⇓ V.

C ⊢ E1 ⇓ V1, C ⊢ E2 ⇓ V2, V is V1 + V2,!
--%------------------------------------ (E-Plus)
C ⊢ E1 + E2 ⇓ V.

C ⊢ E1 ⇓ V1, C ⊢ E2 ⇓ V2, V is V1 - V2,!
--%------------------------------------ (E-Minus)
C ⊢ E1 - E2 ⇓ V.

C ⊢ E1 ⇓ V1, C ⊢ E2 ⇓ V2,
(V1 < V2, V = true; V = false),!
--%------------------------------------ (E-Lt)
C ⊢ E1 < E2 ⇓ V.

C ⊢ E1 ⇓ V1, (C, X:V1) ⊢ E2 ⇓ V2
--%------------------------------------ (E-Let)
C ⊢ let X = E1 in E2 ⇓ V2.

atom(X),!, lookup(C, X : V),!
--%------------------------------------ (E-Var)
C ⊢ X ⇓ V.

!
--%------------------------------------ (E-Fun)
C ⊢ (X -> E) ⇓ (C ⊢ X -> E).

C ⊢ E ⇓ V,
string_codes(S, V),!,write(S),!
--%------------------------------------ (E-AppPrintString)
C ⊢ (print_string $ E) ⇓ V.

C ⊢ E ⇓ V,
number_string(I, V),!
--%------------------------------------ (E-AppIntOfString)
C ⊢ (int_of_string $ E) ⇓ I.

C ⊢ E ⇓ V,
string_codes(S, V),!,write(S),nl,!
--%------------------------------------ (E-AppPrintlnString)
C ⊢ (println_string $ E) ⇓ V.

C ⊢ E ⇓ V,write(V),nl,!
--%------------------------------------ (E-AppPrintlnInt)
C ⊢ (println_int $ E) ⇓ V.

C ⊢ E ⇓ V,write(V),nl,!
--%------------------------------------ (E-AppPrintlnBool)
C ⊢ (println_bool $ E) ⇓ V.

C ⊢ E1 ⇓ (C2 ⊢ X -> E0), C ⊢ E2 ⇓ V2,
(C2,X:V2) ⊢ E0 ⇓ V
--%------------------------------------ (E-App)
C ⊢ (E1 $ E2) ⇓ V.

(C,X:V1) ⊢ E1 ⇓ V1,
(C,X:V1) ⊢ E2 ⇓ V2
--%------------------------------------ (E-LetRec)
C ⊢ (letrec X = E1 in E2) ⇓ V2.

C ⊢ E1 ⇓ V, C ⊢ E2 ⇓ V2
--%------------------------------------ (E-Cons)
C ⊢ (E1::E2) ⇓ [V|V2].

C ⊢ E1 ⇓ V, C ⊢ E2 ⇓ V2
--%------------------------------------ (E-Cons2)
C ⊢ [E1|E2] ⇓ [V|V2].

!
--%------------------------------------ (E-Nil)
C ⊢ [] ⇓ [].

C ⊢ E1 ⇓ [], C ⊢ E2 ⇓ V
--%------------------------------------ (E-MatchNil)
C ⊢ match(E1 | [] -> E2 | _) ⇓ V.

C ⊢ E1 ⇓ [V1|V2],
((C,X : V1),Y : V2) ⊢ E3 ⇓ V
--%------------------------------------ (E-MatchCons)
C ⊢ match(E1 | _ | X::Y->E3) ⇓ V.

%% typing rules

integer(I)
--%------------------------------------ (T-Int)
Γ ⊢ I : int.

bool(B)
--%------------------------------------ (T-Bool)
Γ ⊢ B : bool.

Γ ⊢ E1 : bool, Γ ⊢ E2 : T, Γ ⊢ E3 : T
--%------------------------------------ (T-If)
Γ ⊢ (if E1 then E2 else E3) : T.

Γ ⊢ E1 : int, Γ ⊢ E2 : int
--%------------------------------------ (T-Plus)
Γ ⊢ E1 + E2 : int.

Γ ⊢ E1 : int, Γ ⊢ E2 : int
--%------------------------------------ (T-Minus)
Γ ⊢ E1 - E2 : int.

Γ ⊢ E1 : int, Γ ⊢ E2 : int
--%------------------------------------ (T-Lt)
Γ ⊢ (E1 < E2) : bool.

atom(X), lookup(Γ, X : T)
--%------------------------------------ (T-Var)
Γ ⊢ X : T.

(Γ,X:T) ⊢ E : T2
--%------------------------------------ (T-Fun)
Γ ⊢ (X -> E) : (T -> T2).

Γ ⊢ E1 : (T2 -> T), Γ ⊢ E2 : T2
--%------------------------------------ (T-App)
Γ ⊢ E1 $ E2 : T.

Γ ⊢ E1 : T1, (Γ,X:T1) ⊢ E2 : T2
--%------------------------------------ (T-Let)
Γ ⊢ (let X = E1 in E2) : T2.

Γ ⊢ E1 : T, Γ ⊢ E2 : list(T)
--%------------------------------------ (T-List)
Γ ⊢ (E1::E2) : list(T).

Γ ⊢ E1 : T, Γ ⊢ E2 : list(T)
--%------------------------------------ (T-List2)
Γ ⊢ [E1|E2] : list(T).

!
--%------------------------------------ (T-Nil)
Γ ⊢ [] : list(_).

Γ ⊢ E1 : list(T1), Γ ⊢ E2 : T,
((Γ,X : T1), Y : list(T1)) ⊢ E3 : T
--%------------------------------------ (T-MatchCons)
Γ ⊢ match(E1 | [] -> E2 | X::Y->E3) : T.

(Γ,X:T1) ⊢ E1 : T1, (Γ,X:T1) ⊢ E2 : T2
--%------------------------------------ (T-LetRec)
Γ ⊢ (letrec X = E1 in E2) : T2.

!
--%------------------------------------ (T-Error)
Γ ⊢ E1 : "type error".

add_env(V,E,E2):- E2=(E,V).

env -->
  add_env(print_string:(list(int)->list(int))),
  add_env(println_string:(list(int)->list(int))),
  add_env(println_int:(int->int)),
  add_env(println_bool:(bool->bool)),
  add_env(int_of_string:(list(int)->int)).

main :-
  current_prolog_flag(argv, ARGV),
  [File|_]=ARGV,
  setup_call_cleanup(open(File, read, In),
        read_string(In, _, S),
        close(In)),
  catch(term_string(E,S),error(Err,string(ErrS,ErrPos)),(write(Err),write(':'),write(ErrS),halt)),
  maplist(string_codes,ARGV,ARGV2),
  env([],Env),
  (Env,(argv:list(list(int)))) ⊢ E : T, 
  (
    T="type error", write('type error\n');
    ([],(argv:ARGV2)) ⊢ E ⇓ _;
    write('runtime error\n')
  ),
  halt.
