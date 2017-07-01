%------------------------------------------------------------------------------
%	PROBLEMA NIVEL NORMAL DO RACHA CUCA
%------------------------------------------------------------------------------
%	Link: https://rachacuca.com.br/logica/problemas/amigas-na-praia/
%	Enunciado: Cinco amigas estão curtindo um dia de sol na praia. Através da lógica, descubra as características delas.
%
%	AMIGAS NA PRAIA
%
%Dicas do problema:
% 01 - Na terceira posição está a amiga que gosta de picolé de Chocolate;
% 02 - Quem gosta de Dançar está ao lado de quem está usando protetor solar de fator 35;
% 03 - A mulher de biquíni Verde está em algum lugar à esquerda da mulher mais nova;
% 04 - A amiga de biquíni Amarelo gosta de picolé de Maracujá;
% 05 - A mulher que gosta de Fotografar está ao lado de quem está usando protetor de fator 35;
% 06 - A amiga que gosta de picolé de Uva está exatamente à esquerda da mulher que gosta de picolé de Abacaxi;
% 07 - A mulher de biquíni Amarelo está em algum lugar entre a mulher de 23 anos e e a mulher que gosta de Fotografar, nessa ordem;
% 08 - Quem está usando o protetor de fator 35 gosta de Pescar;
% 09 - Marisa está ao lado de quem está usando o protetor de fator 45;
% 10 - A mulher de biquíni Vermelho gosta de picolé de Abacaxi;
% 11 - Em uma das pontas está a amiga que gosta de Fotografar;
% 12 - A amiga de biquíni Amarelo está em algum lugar entre a Paloma e a amiga que gosta de Dançar, nessa ordem;
% 13 - Quem está usando o protetor de fator 45 está exatamente à esquerda de quem gosta de picolé de Chocolate;
% 14 - Na segunda posição está a amiga que gosta de Ler;
% 15 - A mulher de 22 anos está na terceira posição;
% 16 - Ângela está usando um biquíni Verde;
% 17 - A amiga de 21 anos está em algum lugar à direita da amiga de biquíni Branco;
% 18 - Quem está usando protetor de fator 35 está ao lado de quem está usando protetor de fator 50;
% 19 - Érica está ao lado da amiga que gosta de Dançar;
% 20 - A mulher que gosta de picolé de Chocolate está usando protetor de fator 40;
% 21 - A mulher mais velha está em algum lugar à esquerda da mulher de biquíni Branco.
%
%Dicas extras com os elementos que faltam nas dicas do problema, explicitando somente os a existencia de tais itens e a que tipo eles pertencem;
% A1 - Existe um biquini azul;
% A2 - Existe um nome jessica;
% A3 - Existe um protetor solar fator 30;
% A4 - Existe um picole de goiaba;
% A5 - Existe um hobby cozinhar.


%------------------------------------------------------------------------------
%	SOLUCAO
% Os itens marcados com asterisco não constão nas dicas do problema então foram incluidos como dicas auxiliares.
%------------------------------------------------------------------------------

%Estrutura esperada da resposta do programa em prolog.
%[amiga(azul, paloma, fps30, goiaba, anos23, cozinhar), 
% amiga(amarelo, erica, fps45, maracuja, anos24, ler), 
% amiga(branco, marisa, fps40, chocolate, anos22, dancar), 
% amiga(verde, angela, fps35, uva, anos21, pescar), 
% amiga(vermelho, jessica, fps50, abacaxi, anos20, fotografar)]

%Estrutura da resposta no site do rachacuca
%				Amiga1		Amiga2		Amiga3		Amiga4		Amiga5
% biquini		*azul		amarelo		branco		verde		vermelho
% nome			paloma		erica		marisa		angela		*jessica
% protetor		*fps30		fps45		fps40  		fps35		fps50
% picole		*goiaba		maracuja	chocolate   uva			abacaxi
% idade			anos23		anos24		anos22		anos21		anos20
% hobby			*cozinhar	ler			dancar		pescar		fotografar


%------------------------------------------------------------------------------
%	REGRAS
%------------------------------------------------------------------------------

%	AUXILIARES
% As regras auxiliares abaixo são validas para listas onde os elementos não se repetem e os argumentos X e Y são diferentes.
%------------------------------------------------------------------------------

% X esta vizinho de Y na lista.
% X -> Elemento.
% Y -> Vizinho do elemento.
% L -> Lista de elementos.
ao_lado(X, Y, L) :- a_direita(X, Y, L). % X à direita de Y
ao_lado(X, Y, L) :- a_direita(Y, X, L). % Y à direita de X

% X esta vizinho ao lado direito de Y na lista.
% X -> Elemento.
% Y -> Vizinho do lado esquerdo de X.
% Terceiro argumento é uma lista de elementos.
a_direita(X, Y, [Y | [X | _]]).
a_direita(X, Y, [_ | T]) :- a_direita(X, Y, T).

% X esta vizinho ao lado esquerdo de Y na lista.
% X -> Elemento.
% Y -> Vizinho do lado direito de X.
% Terceiro argumento é uma lista de elementos.
a_esquerda(X, Y, [X | [Y | _]]).
a_esquerda(X, Y, [_ | T]) :- a_esquerda(X, Y, T).

% X esta em qualquer posição a esquerda de Y na lista.
% X -> Elemento.
% Y -> Elemento que está a direita.
% Terceiro argumento é uma lista de elementos.
esquerda(X,Y,[X | T]) :- member(Y,T).
esquerda(X,Y,[_ | T]) :- esquerda(X,Y,T).

% X esta em qualquer posição a direita de Y na lista.
% X -> Elemento.
% Y -> Elemento que está a esquerda.
% Terceiro argumento é uma lista de elementos.
direita(X,Y,L) :- esquerda(Y,X,L).

% Z esta entre X e Y na lista, sendo que X esta a esquerda de Z e Y esta a direita de Z.
% X -> Elemento que está a esquerda.
% Y -> Elemento que está a direita.
% Z -> Elemento.
% L -> Lista de elementos.
entre(X, Y, Z, L):- esquerda(X, Z, L), direita(Y, Z, L). 

% X esta nas pontas da lista L, ou seja, X é o primeiro ou o ultimo elemento da lista L. 
% X -> Elemento.
% L -> Lista de elementos.
pontas(X, L):- [X, _, _, _, _] = L.
pontas(X, L):- [_, _, _, _, X] = L.

%	REGRA DE SOLUCAO PARA O PROBLEMA
%------------------------------------------------------------------------------
solucao(Amigas) :-
% amiga(biquini, nome, protetor, picole, idade, hobby)
	Amigas = [_, _, _, _, _], % lista com 5 elementos
% A1 - Existe um biquini azul.	
	member(amiga(azul, _, _, _, _, _), Amigas),
% A2 - Existe um nome jessica.	
	member(amiga(_, jessica, _, _, _, _), Amigas),
% A3 - Existe um protetor solar fator 30.	
	member(amiga(_, _, fps30, _, _, _), Amigas),
% A4 - Existe um picole de goiaba.	
	member(amiga(_, _, _, goiaba, _, _), Amigas),
% A5 - Existe um hobby cozinhar.	
	member(amiga(_, _, _, _, _, cozinhar), Amigas),	
% 01 - Na terceira posição está a amiga que gosta de picolé de Chocolate.
	[_, _, amiga(_, _, _, chocolate, _, _), _, _] = Amigas,
% 02 - Quem gosta de Dançar está ao lado de quem está usando protetor solar de fator 35.
	ao_lado(amiga(_, _, _, _, _, dancar), amiga(_, _, fps35, _, _, _), Amigas),
% 03 - A mulher de biquíni Verde está em algum lugar à esquerda da mulher mais nova.
	esquerda(amiga(verde,_,_,_,_,_), amiga(_,_,_,_,anos20,_), Amigas),
% 04 - A amiga de biquíni Amarelo gosta de picolé de Maracujá.
	member(amiga(amarelo, _, _, maracuja, _, _), Amigas),
% 05 - A mulher que gosta de Fotografar está ao lado de quem está usando protetor de fator 35.
	ao_lado(amiga(_, _, _, _, _, fotografar), amiga(_, _, fps35, _, _, _), Amigas), 
% 06 - A amiga que gosta de picolé de Uva está exatamente à esquerda da mulher que gosta de picolé de Abacaxi.
	a_esquerda(amiga(_, _, _, uva, _, _), amiga(_, _, _, abacaxi, _, _), Amigas),
% 07 - A mulher de biquíni Amarelo está em algum lugar entre a mulher de 23 anos e a mulher que gosta de Fotografar, nessa ordem.
	entre(amiga(_, _, _, _, anos23, _), amiga(_, _, _, _, _, fotografar), amiga(amarelo, _, _, _, _, _), Amigas),
% 08 - Quem está usando o protetor de fator 35 gosta de Pescar.
	member(amiga(_, _, fps35, _, _, pescar), Amigas),
% 09 - Marisa está ao lado de quem está usando o protetor de fator 45.
	ao_lado(amiga(_, marisa, _, _, _, _), amiga(_, _, fps45, _, _, _), Amigas),
% 10 - A mulher de biquíni Vermelho gosta de picolé de Abacaxi.
	member(amiga(vermelho, _, _, abacaxi, _, _), Amigas),
% 11 - Em uma das pontas está a amiga que gosta de Fotografar.
	pontas(amiga(_,_,_,_,_,fotografar), Amigas),
% 12 - A amiga de biquíni Amarelo está em algum lugar entre a Paloma e a amiga que gosta de Dançar, nessa ordem.
	entre(amiga(_, paloma, _, _, _, _), amiga(_, _, _, _, _, dancar), amiga(amarelo, _, _, _, _, _), Amigas),
% 13 - Quem está usando o protetor de fator 45 está exatamente à esquerda de quem gosta de picolé de Chocolate.
	a_esquerda(amiga(_,_,fps45,_,_,_), amiga(_,_,_,chocolate,_,_), Amigas),
% 14 - Na segunda posição está a amiga que gosta de Ler.
	[_, amiga(_, _, _, _, _, ler), _, _, _] = Amigas,
% 15 - A mulher de 22 anos está na terceira posição.
	[_, _, amiga(_, _, _, _, anos22, _), _, _] = Amigas,
% 16 - Ângela está usando um biquíni Verde.
	member(amiga(verde, angela, _, _, _, _), Amigas),
% 17 - A amiga de 21 anos está em algum lugar à direita da amiga de biquíni Branco.
	direita(amiga(_,_,_,_,anos21,_), amiga(branco,_,_,_,_,_), Amigas),
% 18 - Quem está usando protetor de fator 35 está ao lado de quem está usando protetor de fator 50.
	ao_lado(amiga(_, _, fps35, _, _, _), amiga(_, _, fps50, _, _, _), Amigas),
% 19 - Érica está ao lado da amiga que gosta de Dançar.
	ao_lado(amiga(_, erica, _, _, _, _), amiga(_, _, _, _, _, dancar), Amigas),
% 20 - A mulher que gosta de picolé de Chocolate está usando protetor de fator 40.
	member(amiga(_, _, fps40, chocolate, _, _), Amigas),
% 21 - A mulher mais velha está em algum lugar à esquerda da mulher de biquíni Branco.
  esquerda(amiga(_,_,_,_,anos24,_), amiga(branco,_,_,_,_,_), Amigas).
  






