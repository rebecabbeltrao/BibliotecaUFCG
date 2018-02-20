:- initialization (main).

cadastraTitulo([],Titulo,[Titulo]).
cadastraTitulo([X|Y],Titulo,[X|Z]) :- cadastraTitulo(Y,Titulo,Z).

cadastraAutor([],Autor,[Autor]).
cadastraAutor([X|Y],Autor,[X|Z]) :- cadastraAutor(Y, Autor, Z).


cadastraEditora([],Editora,[Editora]).
cadastraEditora([X|Y],Editora,[X|Z]) :- cadastraEditora(Y,Editora,Z).


cadastraTitulo(Titulo) :- write("bababab").
cadastraAutor(Autor) :- write("assdsds").
cadastraEditora(Editora) :- write("wshdhdhwdj").

runOption(1) :- 
 write("CADASTRO DE LIVRO - Digite o nome do livro que deseja cadastrar:"),nl,
 read(Titulo),
 cadastraTitulo(Titulo),
 write("Informe o Autor do Livro: "),nl,
 read(Autor), 
 cadastraAutor(Autor),
 write("Informe a Editora do Livro: "), nl,
 read(Editora),
 cadastraEditora(Editora).
 

runOption(2) :-
 write("LISTAGEM DE LIVROS"), nl.

runOption(3) :- 
write("ALUGUEL DE LIVROS - Digite o nome do livro que deseja alugar: "), nl,
read(LivroAlugar), 
write( "Livro alugado com sucesso!"), nl.

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


/*
runOption(Option) :- Option == 2, menuLista().
runOption(Option) :- Option == 3, menuAluga().
runOption(Option) :- Option == 4, menuDevolve().

*/
halt(0).
