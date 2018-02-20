:- initialization (main).

runOption(1) :- 
 write("CADASTRO DE LIVRO - Digite o nome do livro que deseja cadastrar:"),nl,
 read(Titulo),
 write("Informe o Autor do Livro: "),nl,
 read(Autor), 
 write("Informe a Editora do Livro: "), nl,
 read(Editora),
 write("Informe o Ano do Livro: "), nl,
 read(Ano),
 assertz(livro(Titulo, Autor, Editora, Ano)).

runOption(2) :-
 write("LISTAGEM DE LIVROS"), nl,
 findall(A,livro(A,B,C,D),Lista),
 listagemLivro(Lista).

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

runOption(3) :- 
write("ALUGUEL DE LIVROS - Digite o nome do livro que deseja alugar: "), nl,
read(Titulo),
assertz(alugado(Titulo)),
write("Livro alugado com sucesso!"), nl.

runOption(4):-
write("LISTAGEM DE LIVROS ALUGADOS"), nl,
findall(Livro,alugado(Livro),Lista),
listagemAlugados(Lista).

listagemAlugados([]):- main.
listagemAlugados([HEAD|TAIL]) :-
	write("Titulo: "),
	write(HEAD), nl,
	alugado(HEAD),
	write("Status: ALUGADO"),nl,
	listagemAlugados(TAIL).

runOption(5):- 
write("DEVOLUÇAO DE LIVROS - Digite o titulo do livro que deseja devolver: "), nl,
read(LivroDevolver),
call(alugado(LivroDevolver)),!,
retract(alugado(LivroDevolver)),
write("Livro devolvido com sucesso!"). 


runOption(6):- write("BUSCA DE LIVROS CADASTRADOS"),nl,
write("Digite o titulo do Livro: "), nl,
read(Titulo), 
write("Digite o Autor: "),nl,
read(Autor),
write("Digite a Editora: "),nl,
read(Editora),
write("Digite o Ano: "),nl,
read(Ano),
findall(A, livro(A,B,C,D), Lista),
buscaLivro(Titulo, Lista).

runOption(7):- write("BUSCA DE LIVROS ALUGADOS"),nl,
write("Digite o titulo do livro: "), nl,
read(Titulo),
findall(Livro, alugado(Livro), Lista),
buscaAlugado(Titulo, Lista).

buscaAlugado(Titulo, Lista) :- pertence(Titulo, Lista), write("Livro encontra-se alugado."), nl.
buscaAlugado(Titulo, Lista) :- write("Livro nao alugado."), nl.

buscaLivro(Titulo, Lista):- pertence(Titulo,Lista), write("Livro cadastrado."),nl.
buscaLivro(Titulo, Lista):- write("Livro nao cadastrado."),nl.

pertence(Titulo,Lista) :- Lista = [Titulo|_].
pertence(Titulo,Lista) :- Lista = [_|TAIL], pertence(Lista,TAIL).
  
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
write("Por favor, informe a sua escolha: "), nl,
read(Option),
runOption(Option), main.
