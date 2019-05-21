% Autores:
% alumno_prode(Apellido2,Apellido1,Nombre,NumMatricula)
alumno_prode('Sanchez','Nieves','Victor','X150375').
alumno_prode('Ayllon','Carmona','Alejandro','X150251').
alumno_prode('Perez','Morgera','Daniel','X150284').

% devuelve en M el menor entre A y B usando Comp como criterio de comparación.


menor(A,B,Comp,M):-
	functor(X,Comp,2),
	arg(1,X,A),
	arg(2,X,B),
	call(X),
	M=A,!.
menor(A,B,Comp,M):-
	functor(X,Comp,2),
	arg(1,X,A),
	arg(2,X,B),
	\+ call(X),
	M=B,!.















% determina si su primer argumento es menor o igual al segundo
menor_o_igual(A,B):-
	functor(A,PA,_),
	functor(B,PB,_),
	PA@<PB,!.
menor_o_igual(A,B):-
	functor(A,PA,_),
	functor(B,PB,_),
	PA@>PB,!.
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
	comparar_listas(XA,XB).

% compara si cada uno de los elementos es menor o mayor en cada lista
comparar_listas([],[]).
comparar_listas([A|_],[B|_]):-
	A@<B,
	true.
comparar_listas([A|A2],[B|B2]):-
	A=B,
	comparar_listas(A2,B2).
comparar_listas([A|_],[B|_]):-
	A@>B,
	false.

% dada una lista, devuelve otra con las hojas que compondrán el árbol	
lista_hojas([],[]).
lista_hojas([L|Resto],[tree(L,void,void)|H]):-
	lista_hojas(Resto,H).

%hojas_arbol
%Programar un predicado hojas arbol(Hoja, Com, Arbol) que, dada la lista de hojas devuelve el
%´arbol flotante inicial:
%tree(1,tree(1,tree(1,void,void),tree(2,void,void)),tree(3,void,void))
%hojas_arbol([],_,[]).
hojas_arbol([],_,_).
hojas_arbol(tree(A,B,C),_,tree(A,B,C)).
hojas_arbol([Hoja,Hoja2|Resto],Comp,Arbol):-
	menor(Hoja,Hoja2,Comp,M),
	arg(1,M,I),
	%append(Arbol,[tree(I,Hoja,Hoja2)],AR),
	Arbol=tree(I,Hoja,Hoja2),
	hojas_arbol(Resto,Comp,Arbol).
