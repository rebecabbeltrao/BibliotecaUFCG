

cadastra:: String -> String -> String -> String -> IO()
cadastra nome autor editora alugado = do
 appendFile "titulos.txt" (nome++ ",")
 appendFile "autores.txt" (autor ++ ",")
 appendFile "editora.txt" (editora ++ ",")
 appendFile "alugados.txt" (alugado ++ "N")


listagemLivros = do
   nomeLivro <- readFile "titulos.txt"
   if(length nomeLivro == 0) then do
	  putStrLn "Livro Inexistente ou não cadastrado"
   else do
	  (a:as) <- readFile ("titulos.txt")
	  (b:bs) <- readFile ("autores.txt")
	  (c:cs) <- readFile ("editora.txt")
	  (d:ds) <- readFile ("alugados.txt")

	  let (nomeLivro:outrosLivros) = listaLivros(a:as) "" []
	  let (autor:outroAutores) = listaLivros (b:bs) "" []
	  let (editora:outraEditora) = listaLivros(c:cs) "" []
	  let (alugados: maisAlugados) = listaLivros(d:ds) "" []
	  imprime (nomeLivro:outrosLivros) (autor:outroAutores) (editora:outraEditora) (alugados: maisAlugados)
	  

imprime:: [String] -> [String] -> [String]-> [String] -> IO()
imprime [""] [""] [""] [""] = putStrLn ("Listagem Encerrada")
imprime (livro:outrosLivros) (autor:outroAutores) (editora:outraEditora) (alugados:maisAlugados) = do
   if(alugados == "N") then do
      imprime outrosLivros outroAutores outraEditora maisAlugados
   else do
      putStrLn ("Nome Livro: " ++ livro)
      putStrLn ("Autor: " ++ autor)
      putStrLn ("Editora: " ++ editora)
      imprime outrosLivros outroAutores outraEditora maisAlugados
      
listaLivros:: String -> String -> [String] -> [String]
listaLivros [] nome [] = []
listaLivros [] nome lista = lista ++ [nome]
listaLivros (x:xs) i lista = do
     if([x] == ",") then do 
         listaLivros xs (i ++ [x])lista
     else if( [x] /= "," && [x] /= "") then do
         listaLivros xs "" (lista ++[i])
     else 
         lista ++ [i]


-- "A" Para alugado e "N" Para não alugado 
aluga :: String -> [String] -> String -> String
aluga nome [] [] = ""
aluga nome [""] "" = ""
aluga nome (head:titulos) (tail:alugados) 
             | (nome == head) = "A" ++ aluga nome titulos alugados 
             | (nome == "") = "" ++ aluga nome titulos alugados
             | otherwise = [tail] ++ aluga nome titulos alugados

-- devolução 
devolucao :: String -> [String] -> String -> String
devolucao nome [] [] = ""
devolucao nome [""] "" = ""
devolucao nome (head:titulos) (tail:alugados) 
             | (nome == head) = "N" ++ aluga nome titulos alugados 
             | (nome == "") = "" ++ aluga nome titulos alugados
             | otherwise = [tail] ++ aluga nome titulos alugados


-- atualiza (salva nomes na lista)
atualiza :: String -> String -> [String] -> [String] -> [String]
atualiza nome status [""] [""] = []
atualiza nome status (x:titulos) (a:alugados) = do 
         if(nome /= x ) then do
             [x] ++  atualiza nome status titulos alugados
          else 
              status ++ atualiza nome status titulos alugados

reescreve :: IO()
reescreve = do 
     writeFile "titulos.txt" ("")
     writeFile "autores.txt" ("")
     writeFile "editora.txt" ("")
     
-- alice A listadeT listA



main = do 
     print "Menu"
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
         alugado <- getLine
         cadastra nome autor editora alugado
         
     else if( op == "2") then do
         listagemLivros
     else if( op=="3") then do
        -- putStrLn "ALUGUEL DE LIVROS - Digite o nome do livro que deseja alugar:"
         (x:xs) <- readFile "titulos.txt"
         (w:ws) <- readFile "alugados.txt"
         nome <- getLine
         alugado <- getLine
         let list = atualiza nome alugado (listaLivros (x:xs) "" []) (listaLivros (w:ws) "" [])
         reescreve
         print list
     else do
           a <- readFile "autores.txt"
           print a
           putStrLn "BUSCA DE LIVRO - Digite nome do livro a ser procurado:"
     main

