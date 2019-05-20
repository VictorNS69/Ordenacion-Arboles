% Autores:
% alumno_prode(Apellido2,Apellido1,Nombre,NumMatricula)
alumno_prode('Sanchez','Nieves','Victor','X150375').
alumno_prode('Ayllon','Carmona','Alejandro','X150251').
alumno_prode('Perez','Morgera','Daniel','X150284').

% devuelve en M el menor entre A y B usando Comp como criterio de comparación.
menor(A,B,=,A):-
	A=B.
menor(A,B,<,A):- 
	A<B.
menor(A,B,=<,A):- 
	A=<B,!.
menor(A,B,>,A):- 
	A>B.
menor(A,B,>=,A):- 
	A>=B,!.
menor(A,B,<,B):- 
	B<A.
menor(A,B,=<,B):- 
	B=<A,!.
menor(A,B,>,B):- 
	B>A.
menor(A,B,>=,B):- 
	B>=A,!.

% determina si su primer argumento es menor o igual al segundo
menor_o_igual(A,B):-
	functor(A,_,FA),
	functor(B,_,FB),
	FA<FB,!.
menor_o_igual(A,B):-
	functor(A,_,FA),
	functor(B,_,FB),
	FA>FB,
	false.
menor_o_igual(A,B):-
	functor(A,_,FA),
	functor(B,_,FB),
	FA=FB,
	A=..XA,
	B=..XB,
	aux(XA,XB).
%	arg(1,A,VA),
%	arg(1,B,VB),
%	VA@<VB,	
%	menor_o_igual(A,B).
aux([A|A2],[B|B2]):-
	A@<B,
	aux(A2,B2).
	
	
