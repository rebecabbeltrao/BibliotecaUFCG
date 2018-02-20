:- initialization (main).

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

runOption(3) :- 
write("ALUGUEL DE LIVROS - Digite o nome do livro que deseja alugar: "), nl,
read(T), 
assertz(alugado(T,S)),
write("Livro alugado com sucesso!"), nl.

runOption(4):-
write("LISTAGEM DE LIVROS ALUGADOS"), nl,
findall(A,alugado(A,S),Lista),
listagemAlugados(Lista).

listagemAlugados([]):- main.
listagemAlugados([HEAD|TAIL]) :-
	write("Titulo : "),
	write(HEAD), nl,
	alugado(HEAD,S),
	write("Status: Alugado"),nl,
	listagemAlugados(TAIL).
	

runOption(5):- 
write("DEVOLUÇAO LIVROS - Digite o livro que deseja devolver: "), nl,
read(LivroDevolver),
call(alugado(LivroDevolver,_)),!,
retract(alugado(LivroDevolver,X)),
write("Livro devolvido com sucesso!"). 


runOption(6):- write("BUSCA LIVROS CADASTRADOS"),nl,
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

runOption(7):- write("BUSCA LIVROS ALUGADOS"),nl,
write("Digite o titulo do livro: "), nl,
read(Titulo),
findall(A, alugado(A,S), Lista1),
buscaAlugado(Titulo, Lista1).

buscaAlugado(Titulo, Lista) :- pertence(Titulo, Lista), write("Livro se encontra alugado"), nl.
buscaAlugado(Titulo, Lista) :- write("Livro nao alugado"), nl.

buscaLivro(Titulo, Lista):- pertence(Titulo,Lista), write("livro cadastrado"),nl.
buscaLivro(Titulo, Lista):- write("livro nao cadastrado"),nl.

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


