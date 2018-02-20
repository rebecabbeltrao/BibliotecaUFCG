:- initialization (main).

fato(Option):- write(Option).

runOption(1) :- 
 write("CADASTRO DE LIVRO - Digite o nome do livro que deseja cadastrar:"),nl,
 read(Titulo),
 write("Informe o Autor do Livro: "),nl,
 read(Autor), 
 write("Informe a Editora do Livro: "), nl,
 read(Editora).

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
