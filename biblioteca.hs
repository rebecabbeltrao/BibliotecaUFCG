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
  
 
      imprime (nomeLivro:outrosLivros) (autor:outroAutores) (editora:outraEditora)
     
 
imprime:: [String] -> [String] -> [String] -> IO()
imprime [""] [""] [""]  = putStrLn ("Listagem Encerrada")
imprime (livro:outrosLivros) (autor:outroAutores) (editora:outraEditora) = do
      putStrLn ("Nome Livro: " ++ livro)
      putStrLn ("Autor: " ++ autor)
      putStrLn ("Editora: " ++ editora)
      imprime outrosLivros outroAutores outraEditora
     
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
escreveFileAlugados :: String -> IO()
escreveFileAlugados alugado = do
  appendFile "alugados.txt" (alugado++ ",")
 
-- atualiza (salva nomes na lista)
atualiza :: String -> [String] -> [String]
atualiza nome [""] = []
atualiza nome (x:alugados) = do
         if(nome /= x ) then do
             [x] ++  atualiza nome alugados
          else
             atualiza nome alugados
 
reescreve :: IO()
reescreve = writeFile "alugados.txt" ("")
 
reescreveArquivo ::[String] -> IO()
reescreveArquivo [] = putStrLn "Lista vazia"
reescreveArquivo (x:xs) = do
      escreveFileAlugados x
      reescreveArquivo xs
 
-----------------------------
main:: IO()
main = do
     print "Menu"
     putStrLn("1 - Cadastra Livro ")
     putStrLn("2 - Lista Livros ")
     putStrLn("3 - Aluga Livros ")
     putStrLn("4 - Devolução")
     
     op <- getLine
     if (op == "1") then do
         putStrLn "CADASTRO DE LIVRO - Digite o nome do livro que deseja cadastrar:"
         putStrLn "Informe o Titulo do Livro: "
         nome <- getLine
         putStrLn "Informe o Autor do Livro: "
         autor<- getLine
         putStrLn "Informe a Editora do Livro: "
         editora <- getLine
         cadastra nome autor editora
         
     else if( op == "2") then do
     
         listagemLivros
     else if( op=="3") then do
         putStrLn "ALUGUEL DE LIVROS - Digite o nome do livro que deseja alugar:"
         alugado <- getLine
         escreveFileAlugados alugado
         putStrLn "Livro alugado com sucesso!"
     else if (op =="4") then do
         devolvido <- getLine
         (x:xs) <- readFile "alugados.txt"
         let livros = listaLivros (x:xs) "" []
         let result = atualiza devolvido livros
         print result
         a <- removeFile "alugados.txt"
         reescreve
         reescreveArquivo result
     else do
           a <- readFile "autores.txt"
           print a
           putStrLn "BUSCA DE LIVRO - Digite nome do livro a ser procurado:"
     main
