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

% hojas_arbol(Hoja, Com, Arbol) que, dada la lista de hojas devuelve el arbol flotante inicial:
%hojas_arbol([],_,[]).
hojas_arbol([],_,_).
hojas_arbol([tree(A,B,C)],_,tree(A,B,C)).
hojas_arbol([Hoja,Hoja2|Resto],Comp,Arbol):-
	menor(Hoja,Hoja2,Comp,M),
	arg(1,M,I),
	ArbolA=tree(I,Hoja,Hoja2),
	hojas_arbol_aux(Resto,Comp,ArbolA,M,S),
	Arbol=S.

% Hace hojas_arbol recursivamente
hojas_arbol_aux([],_,A,_,A):-!.
hojas_arbol_aux([],_,tree(A,B,C),_,tree(A,B,C)).
hojas_arbol_aux([Hoja1|Resto],Comp,Arbol,Gana,S):-
	menor(Gana,Hoja1,Comp,M),
	arg(1,M,I),
	ArbolA=tree(I,Arbol,Hoja1),
	hojas_arbol_aux(Resto,Comp,ArbolA,M,S1),
	S=S1.

% Devuelve la misma lista sin el elemento E
eliminar_elemento(E,[E|Z],Z).
eliminar_elemento(E,[V|Z],[V|Y]):-
	E\=V,
	eliminar_elemento(E,Z,Y).

% Extrae las hojas de un arbol
extraer_hojas(void,A,B):-
	[A,B].
extraer_hojas(tree(X,void,void),A,B):-
	append(A,[X],B).
extraer_hojas(tree(_,L,R),A,B):-
	(L\=void, R\=void),
	extraer_hojas(L,A,X),
	extraer_hojas(R,X,B).

% Reflota un arbol sin la raiz R
reflotar(A,Comp,R,NA):-
	extraer_hojas(A,"",L2),
	length(L2,Tam),
	(Tam\=1)->
		eliminar_elemento(R,L2,L3),
		lista_hojas(L3,H),
		hojas_arbol(H,Comp,NA);
	NA=[].

% dado el árbol inicial, devuelve en Orden la lista ordenada.
ordenacion(Arbol,Comp,Orden):-
	ordenacion_aux(Arbol,Comp,_,Orden),!.

% Hace la recursividad de ordenacion
ordenacion_aux([],_,NL,NL).
ordenacion_aux(Arbol,Comp,Aux,Orden):-
	Arbol=..ArbolLista,
	arg(2,ArbolLista,RaizAux),
	arg(1,RaizAux,Raiz),
	append(Aux,[Raiz],NL),
	reflotar(Arbol,Comp,Raiz,NA),
	ordenacion_aux(NA,Comp,NL,Orden).

% ordena una lista de números (transforma a hojas, luego a arbol y devuelve el orden)
ordenar(Lista,Comp,Orden):-
	lista_hojas(Lista,Lhojas),
	hojas_arbol(Lhojas,Comp,Arbol),
	ordenacion(Arbol,Comp,Orden).
