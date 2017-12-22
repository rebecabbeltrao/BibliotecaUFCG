import System.Directory
 
cadastra:: String -> String -> String -> IO()
cadastra nome autor editora = do
 appendFile "titulos.txt" (nome++ ",")
 appendFile "autores.txt" (autor ++ ",")
 appendFile "editora.txt" (editora ++ ",")
 

listagemLivros = do
   nomeLivro <- readFile "titulos.txt"
   if(length nomeLivro == 0) then do
      putStrLn "Livro Inexistente ou não cadastrado"
   else do
      (a:as) <- readFile ("titulos.txt")
      (b:bs) <- readFile ("autores.txt")
      (c:cs) <- readFile ("editora.txt")
 
      let (nomeLivro:outrosLivros) = listaLivros(a:as) "" []
      let (autor:outroAutores) = listaLivros (b:bs) "" []
      let (editora:outraEditora) = listaLivros(c:cs) "" []
      print (nomeLivro:outrosLivros)
      print (autor:outroAutores)
      print (editora:outraEditora)
 
      imprime (nomeLivro:outrosLivros) (autor:outroAutores) (editora:outraEditora)
     
 
imprime:: [String] -> [String] -> [String] -> IO()
imprime [""] [""] [""]  = putStrLn ("Listagem Encerrada")
imprime [] [] []  = putStrLn ("Listagem Encerrada")
imprime (livro:outrosLivros) (autor:outroAutores) (editora:outraEditora) = do
      putStrLn ("Nome Livro: " ++ livro)
      putStrLn ("Autor: " ++ autor)
      putStrLn ("Editora: " ++ editora)
      imprime outrosLivros outroAutores outraEditora
      
-- funcao que gera uma lista de todos os elementos do arquivo
listaLivros:: String -> String -> [String] -> [String]
listaLivros [] nome [] = [nome]
listaLivros [] nome lista = lista ++ [nome]
listaLivros (x:xs) i lista = do
     if([x] == ",") then do
         listaLivros xs "" (lista ++ [i])
     else if( [x] /= "," && [x] /= "") then do
         listaLivros xs (i++[x]) lista
     else
         lista ++ [i]
------------------------------------------------------------------
-- escreve arquivo dos livros alugados
escreveFileAlugados :: String -> IO()
escreveFileAlugados alugado = do
  appendFile "alugados.txt" (alugado++ ",")
 
-- atualiza (salva nomes na lista de livros alugados)
atualiza :: String -> [String] -> [String]
atualiza nome [""] = []
atualiza nome (x:alugados) = do
         if(nome /= x) then do
             [x] ++  atualiza nome alugados
          else
             atualiza nome alugados
             
-- verifica se o livro ja esta alugado
verificaAlugado :: String -> [String] -> Bool
verificaAlugado titulo [] = True
verificaAlugado titulo [""] = True
verificaAlugado titulo (x:xs)= if(x == titulo) then True
                               else verificaAlugado titulo xs
                               
-- reescreve o arquivo de alugado em branco
reescreve :: IO()
reescreve = writeFile "alugados.txt" ("")

-- reescreve o arquivo com a nova lista de alugados 
reescreveArquivo ::[String] -> IO()
reescreveArquivo [] = putStrLn ""
reescreveArquivo[""] = putStrLn ""
reescreveArquivo (x:xs) = do
      escreveFileAlugados x
      reescreveArquivo xs
 
-----------------------------
main:: IO()
main = do
     print "BIBLIOTECA UFCG"
     putStrLn("Escolha uma das opções seguintes:")
     putStrLn("1 - Cadastra Livro ")
     putStrLn("2 - Lista Livros ")
     putStrLn("3 - Aluga Livros ")
     putStrLn("4 - Devolução")
     
     op <- getLine
     if (op == "1") then do
         putStrLn "CADASTRO DE LIVRO - Digite o nome do livro que deseja cadastrar:"
         nome <- getLine
         autor<- getLine
         editora <- getLine
         cadastra nome autor editora
         
     else if( op == "2") then do
         putStrLn "LISTAGEM DE LIVROS"
         putStrLn "deseja listar todos os livros da biblioteca? S/N"
         resposta <- getLine
         if(resposta == "S") then do
          listagemLivros
         else do
           putStrLn "Digite outra opção:"
     else if( op=="3") then do
     
         putStrLn "ALUGUEL DE LIVROS - Digite o nome do livro que deseja alugar:"
         (x:xs) <- readFile "alugados.txt"
         let livros = listaLivros (x:xs) "" []
         alugado <- getLine
         
         if(verificaAlugado alugado livros) then do 
          putStrLn "Livro não disponível para aluguel"
         else do
           escreveFileAlugados alugado
           putStrLn "Livro alugado com sucesso!"
     else do
            devolvido <- getLine
            (x:xs) <- readFile "alugados.txt"
            let livros = listaLivros (x:xs) "" []
            let result = atualiza devolvido livros
            print result
            a <- removeFile "titulos.txt"
            reescreve
            reescreveArquivo result
    
     main
