:- initialization (main).


armazenaAlugados():- write("klb").

listagemLivro([]):- main.
listagemLivro([HEAD|TAIL]):- write("Titulo: "),nl,
write(HEAD), nl,
livro(HEAD,A,B), 
write("Autor:"), nl,
write(A), nl,
write("Editora: "),nl,
write(B),nl,
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
read(LivroAlugar), 
write("Livro alugado com sucesso!"), nl.

runOption(4):-
write("DEVOLUÇAO LIVROS - Digite o livro que deseja devolver: "), nl,
read(LivroDevolver), 
write("Livro devolvido com sucesso!" ), nl.

main:-
nl,
write(" BEM VINDO A BIBLIOTECA UFCG"), nl,
write("MENU"),nl,
write("1 - Cadastra Livro "),nl,
write("2 - Lista Livros "),nl,
write("3 - Aluga Livros "),nl,
write("4 - Devolução"),nl,
write("Por favor, informe a sua escolha: "), nl,
read(Option),
runOption(Option), main.

halt(0).
