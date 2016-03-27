:- initialization(main).
:- op(1200, xfx, [ -- ]).
term_expansion(A -- B, B :- A).
%:- style_check(-singleton).
:- op(910, xfx, [ ⊢ ]).
:- op(900, xfx, [ ⇓ ]).
:- op(900, xfx, [ in ]).
:- op(500, yfx, $).
:- op(10, fx, λ).

bool(true). bool(false).

lookup((_, X :V), X : V).
lookup((Γ, X1:_), X : V) :- X1\==X, lookup(Γ, X : V).
lookup((_, (X :V,_)), X : V).
lookup((Γ, (X1:_,Z)), X : V) :- X1\==X, lookup((Γ,Z), X : V).

%% evaluation rules

integer(I)
--%------------------------------------ (E-Int)
_ ⊢ I ⇓ I.

bool(B)
--%------------------------------------ (E-Bool)
_ ⊢ B ⇓ B.

C ⊢ E1 ⇓ true, C ⊢ E2 ⇓ V
--%------------------------------------ (E-IfTrue)
C ⊢ if(E1, E2, _) ⇓ V.

C ⊢ E1 ⇓ false, C ⊢ E3 ⇓ V
--%------------------------------------ (E-IfFalse)
C ⊢ if(E1, _, E3) ⇓ V.

C ⊢ E1 ⇓ V1, C ⊢ E2 ⇓ V2, V is V1 + V2
--%------------------------------------ (E-Plus)
C ⊢ E1 + E2 ⇓ V.

C ⊢ E1 ⇓ V1, C ⊢ E2 ⇓ V2, V is V1 - V2
--%------------------------------------ (E-Minus)
C ⊢ E1 - E2 ⇓ V.

C ⊢ E1 ⇓ V1, C ⊢ E2 ⇓ V2, V is V1 * V2
--%------------------------------------ (E-Times)
C ⊢ E1 * E2 ⇓ V.

C ⊢ E1 ⇓ V1, C ⊢ E2 ⇓ V2,
(V1 < V2, V = true; V = false)
--%------------------------------------ (E-Lt)
C ⊢ (E1 < E2) ⇓ V.

C ⊢ E1 ⇓ V1, (C, X:V1) ⊢ E2 ⇓ V2
--%------------------------------------ (E-Let)
C ⊢ let(X = E1 in E2) ⇓ V2.

atom(X), lookup(C, X : V)
--%------------------------------------ (E-Var)
C ⊢ X ⇓ V.

!
--%------------------------------------ (E-Fun)
C ⊢ (λ X -> E) ⇓ (C ⊢ λ X -> E).

C ⊢ E1 ⇓ (C2 ⊢ λ X -> E0), C ⊢ E2 ⇓ V2,
(C2,X:V2) ⊢ E0 ⇓ V
--%------------------------------------ (E-App)
C ⊢ (E1 $ E2) ⇓ V.

(C,X:V1) ⊢ E1 ⇓ V1,
(C,X:V1) ⊢ E2 ⇓ V2
--%------------------------------------ (E-LetRec)
C ⊢ letrec(X = E1 in E2) ⇓ V2.

C ⊢ E1 ⇓ V, C ⊢ E2 ⇓ V2
--%------------------------------------ (E-Cons)
C ⊢ [E1|E2] ⇓ [V|V2].

!
--%------------------------------------ (E-Nil)
_ ⊢ [] ⇓ [].

C ⊢ E1 ⇓ [], C ⊢ E2 ⇓ V
--%------------------------------------ (E-MatchNil)
C ⊢ match(E1, [] -> E2, _) ⇓ V.

C ⊢ E1 ⇓ [V1|V2],
(C,X : V1,Y : V2) ⊢ E3 ⇓ V
--%------------------------------------ (E-MatchCons)
C ⊢ match(E1, _, [X|Y]->E3) ⇓ V.

% typing rules

integer(I)
--%------------------------------------ (T-Int)
_ ⊢ I : int.

bool(B)
--%------------------------------------ (T-Bool)
_ ⊢ B : bool.

Γ ⊢ E1 : bool, Γ ⊢ E2 : T, Γ ⊢ E3 : T
--%------------------------------------ (T-If)
Γ ⊢ if(E1, E2, E3) : T.

Γ ⊢ E1 : int, Γ ⊢ E2 : int
--%------------------------------------ (T-Plus)
Γ ⊢ E1 + E2 : int.

Γ ⊢ E1 : int, Γ ⊢ E2 : int
--%------------------------------------ (T-Minus)
Γ ⊢ E1 - E2 : int.

Γ ⊢ E1 : int, Γ ⊢ E2 : int
--%------------------------------------ (T-Times)
Γ ⊢ E1 * E2 : int.

Γ ⊢ E1 : int, Γ ⊢ E2 : int
--%------------------------------------ (T-Lt)
Γ ⊢ (E1 < E2) : bool.

atom(X), lookup(Γ, X : T)
--%------------------------------------ (T-Var)
Γ ⊢ X : T.

(Γ,X:T) ⊢ E : T2
--%------------------------------------ (T-Fun)
Γ ⊢ (λ X -> E) : (T -> T2).

Γ ⊢ E1 : (T2 -> T), Γ ⊢ E2 : T2
--%------------------------------------ (T-App)
Γ ⊢ E1 $ E2 : T.

Γ ⊢ E1 : T1, (Γ,X:T1) ⊢ E2 : T2
--%------------------------------------ (T-Let)
Γ ⊢ let(X = E1 in E2) : T2.

Γ ⊢ E1 : T, Γ ⊢ E2 : list(T)
--%------------------------------------ (T-List)
Γ ⊢ [E1|E2] : list(T).

!
--%------------------------------------ (T-Nil)
_ ⊢ [] : list(_).

Γ ⊢ E1 : list(T1), Γ ⊢ E2 : T,
(Γ,X : T1, Y : list(T1)) ⊢ E3 : T
--%------------------------------------ (T-MatchCons)
Γ ⊢ match(E1, [] -> E2, [X|Y]->E3) : T.

(Γ,X:T1) ⊢ E1 : T1, (Γ,X:T1) ⊢ E2 : T2
--%------------------------------------ (T-LetRec)
Γ ⊢ letrec(X = E1 in E2) : T2.

!
--%------------------------------------ (T-Error)
Γ ⊢ _ : "type error".

run(E) :-
  write(E),!,
  _  ⊢ E : T, write(' : '), write(T),!,
  (T="type error";
  [] ⊢ E ⇓ V, write(' ⇓ '), write(V),!
  ),
  nl.

main :-
  current_prolog_flag(argv, [File|_]),
  seeing(STDIN),see(File),
  read(E),
  seen,see(STDIN),
  run(E),
  halt.

test :-
  run(true),
  run(false),
  run(if(true,2,3)),
  run(if(true,false,true)),
  run(1 < 2),
  run(2 < 2),
  run(1 + 2),
  run(1 * 2),
  run(λ x -> x),
  run((λ x -> x) $ 1),
  run((λ x -> λ y -> x+y) $ 1 $ 2),
  run(let(x=1 in x)),
  run(letrec(sum=(λ x -> if(x < 1, x, x+(sum $ (x - 1)))) in (sum $ 10))),
  run([1,2]),
  run([]),
  run([1]),
  run(match([],[]->10,[x|y]->1)),
  run(match([20],[]->10,[x|y]->x)),
  run(letrec(sum=(λ xs ->
        match(xs,
          []->0,
          [x|xs]->x+(sum $ xs)))
      in sum $ [1,2,3,4,5])),
  run(letrec()),
  halt.
