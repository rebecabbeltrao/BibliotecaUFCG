:- initialization (main).

listagemLivro([]):- main.
listagemLivro([HEAD|TAIL]):- write("Titulo: "),nl,
write(HEAD), nl,
livro(HEAD,Autor,Editora), 
write("Autor:"),
write(Autor), nl,
write("Editora: "),
write(Editora),nl,
listagemLivro(TAIL).

runOption(1) :- 
 write("CADASTRO DE LIVRO - Digite o nome do livro que deseja cadastrar:"),nl,
 read(Titulo),
 write("Informe o Autor do Livro: "),nl,
 read(Autor), 
 write("Informe a Editora do Livro: "), nl,
 read(Editora),
 assertz(livro(Titulo, Autor, Editora)).

runOption(2) :-
 write("LISTAGEM DE LIVROS"), nl,
 findall(A,livro(A,B,C),Lista),
 listagemLivro(Lista).

runOption(3) :- 
write("ALUGUEL DE LIVROS - Digite o nome do livro que deseja alugar: "), nl,
read(T), 
assertz(alugado(T)),
write("Livro alugado com sucesso!"), nl.

runOption(4):-
write("LISTAGEM DE LIVROS ALUGADOS"), nl,
findall(A,alugado(A),Lista),
listagemAlugados(Lista).

listagemAlugados([]):- main.
listagemAlugados([HEAD|TAIL]) :-
	write("Titulo : "),
	write(HEAD), nl,
	alugado(HEAD),
	write("Status: Alugado"),nl,
	listagemAlugados(TAIL).
	

runOption(5):- 
write("DEVOLUÇAO LIVROS - Digite o livro que deseja devolver: "), nl,
read(LivroDevolver),
call(alugado(LivroDevolver)),!,
retract(alugado(LivroDevolver)),
write("Livro devolvido com sucesso!"). 


runOption(6):- write("BUSCA LIVROS CADASTRADOS"),nl,
write("Digite o titulo do livro: "), nl,
read(Titulo), 
write("Digite o autor: "),nl,
read(Autor),
write("Digite a editora: "),nl,
read(Editora),
findall(A, livro(A,B,C), Lista),
buscaLivro(Titulo, Lista).

runOption(7):- write("BUSCA LIVROS ALUGADOS"),nl,
write("Digite o titulo do livro: "), nl,
read(Titulo),
findall(A, alugado(A), Lista1),
findall(A,livro(A,B,C), Lista2),
buscaAlugado(Titulo, Lista1).
buscaLivro(Titulo, Lista2).

buscaAlugado(Titulo, Lista) :- pertence(Titulo, Lista), write("Livro se encontra alugado"), nl.
buscaAlugado(Titulo, Lista) :- write("Livro não alugado"), nl.

buscaLivro(Titulo, Lista):- pertence(Titulo,Lista), write("livro cadastrado"),nl.
buscaLivro(Titulo, Lista):- write("livro não cadastrado"),nl.

pertence(A,B) :- B = [A|_].
pertence(A,B) :- B = [_|C], pertence(A,C).
  
main:-
nl,
write(" BEM VINDO A BIBLIOTECA UFCG"), nl,nl,
write("MENU"),nl,
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

halt(0).

