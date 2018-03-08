:- initialization (main).

:- dynamic 
	livro(_,_,_,_),
	alugado(_,_).

runOption(1) :- 
	write("CADASTRO DE LIVRO - Digite o nome do livro que deseja cadastrar:"),nl,
	read(Titulo),
	write("Informe o Autor do Livro: "),nl,
	read(Autor), 
	write("Informe a Editora do Livro: "), nl,
	read(Editora),
	write("Informe o Ano do Livro: "), nl,
	read(Ano),
	assertz(livro(Titulo, Autor, Editora, Ano)),
	write("Livro cadastrado com sucesso.").

runOption(2) :-
	write("LISTAGEM DE LIVROS"), nl,
	findall(A,livro(A,_,_,_),Lista),
	listagemLivro(Lista).
	

runOption(3) :- 
write("ALUGUEL DE LIVROS - Digite o nome do livro que deseja alugar: "), nl,
	read(Titulo),
	write("Digite o autor do livro: "), nl,
	read(Autor),
	call(livro(Titulo,Autor,_,_)),!,
	aluga(Titulo, Autor);
	write("Livro nao cadastrado.").


runOption(4):-
write("LISTAGEM DE LIVROS ALUGADOS"), nl,
	findall(Livro,alugado(Livro, Autor),Lista),
	listagemAlugados(Lista).

runOption(5):- 
	write("DEVOLUÇAO DE LIVROS - Digite o titulo do livro que deseja devolver: "), nl,
	read(Livro),
	write("Digite o autor do livro: "), nl,
	read(Autor),
	devolve(Livro, Autor).

runOption(6):- write("BUSCA DE LIVROS CADASTRADOS"),nl,
	write("Digite o titulo do Livro: "), nl,
	read(Titulo), 
	write("Digite o Autor: "),nl,
	read(Autor),
	write("Digite a Editora: "),nl,
	read(Editora),
	write("Digite o Ano: "),nl,
	read(Ano),
	call(livro(Titulo,Autor,Editora,Ano)),!,
	write("Livro cadastrado.");
	write("Livro nao cadastrado.").

runOption(7):- write("BUSCA DE LIVROS ALUGADOS"),nl,
	write("Digite o titulo do livro: "), nl,
	read(Titulo),
	write("Digite o autor do livro: "), nl,
	read(Autor),
	buscaAlugado(Titulo,Autor).

runOption(8):- halt(0).
runOption(_):- write("opcao invalida"),main.

%------------------ devolve livro alugado--------------------------
devolve(Titulo, Autor):- 	
	call(alugado(Titulo, Autor)),!,
	retract(alugado(Titulo, Autor)),
	write("Livro devolvido com sucesso!");
	write("Livro nao devolvido.").
	
%---------------- lista livro alugado -------------------------------------	
listagemAlugados([]):- main.
listagemAlugados([HEAD|TAIL]) :-
	write("Titulo: "),
	write(HEAD), nl,
	alugado(HEAD,Autor),
	write("Autor: "),
	write(Autor),nl,
	write("Status: ALUGADO"),nl,
	listagemAlugados(TAIL).	

%-------------------------busca alugado---------------------------
buscaAlugado(Titulo,Autor):- call(alugado(Titulo,Autor)),!,
	write("Livro ja esta alugado.");
	write("Livro disponivel para aluguel").
	
%--------------- lista livros alugados ----------------------------------	
listagemLivro([]):- main.
	listagemLivro([HEAD|TAIL]):- nl, write("Titulo: "),
	write(HEAD), nl,
	livro(HEAD,Autor,Editora, Ano), 
	write("Autor:"),
	write(Autor), nl,
	write("Editora: "),
	write(Editora),nl,
	write("Ano: "),
	write(Ano), nl,
	listagemLivro(TAIL).	
	
%----------- aluga livro -----------------------------------------------	
aluga(Titulo, Autor):- call(alugado(Titulo, Autor)),!,
	write("Livro indisponivel para aluguel");
	assertz(alugado(Titulo, Autor)),
	write("Livro alugado com sucesso").	

main:-
nl,
write("
___  _ ___  _    _ ____ ___ ____ ____ ____    _  _ ____ ____ ____ 
|__] | |__] |    | |  |  |  |___ |    |__|    |  | |___ |    | __ 
|__] | |__] |___ | |__|  |  |___ |___ |  |    |__| |    |___ |__] 
                                                                                                                               
"), nl,
write("1 - Cadastra Livro "),nl,
write("2 - Lista Livros "),nl,
write("3 - Aluga Livros "),nl,
write("4 - Lista Livros Alugados"),nl,
write("5 - Devolução"),nl,
write("6 - Buscar Livro"),nl,
write("7 - Buscar livro alugado"),nl,
write("8 - Sair"),nl,
write("Por favor, informe a sua escolha: "), nl,
read(Option),
runOption(Option), main.
