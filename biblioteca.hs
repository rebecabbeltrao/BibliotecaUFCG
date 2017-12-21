cadastra:: String -> String -> String -> IO()
cadastra nome autor editora = do
 appendFile "titulos.txt" (nome++ "*")
 appendFile "autores.txt" (autor ++ "*")
 appendFile "editora.txt" (editora ++ "*")


remove :: String -> Bool
remove livro = True

listaLivros:: String -> String -> [String] -> [String]
listaLivros [] nome [] = []
listaLivros [] nome lista = lista ++ [nome]
listaLivros (x:xs) i lista = do
     if([x] == "*") then do 
         listaLivros xs (i ++ [x])lista
     else if( [x] /= "*" && [x] /= "") then do
         listaLivros xs "" (lista ++[i])
     else 
         lista ++ [i]


-- "A" Para alugado e "N" Para não alugado 
aluga :: String -> [String] -> String -> String
aluga nome [] [] = ""
aluga nome [""] "" = ""
aluga nome (head:titulos) (tail:alugados) 
             | (nome == head) = "A" ++ aluga nome titulos alugados 
             | (nome /= head) = "N" ++ aluga nome titulos alugados
             | otherwise = [tail] ++ aluga nome titulos alugados


main = do 
     print "Menu"
     op <- getLine
     if (op == "1") then do
         putStrLn "CADASTRO DE LIVRO - Digite o nome do livro que deseja cadastrar:"
         nome <- getLine
         autor<- getLine
         editora <- getLine
         cadastra nome autor editora
         
     else if( op == "2") then do
         putStrLn "REMOÇÃO DE LIVRO - Digite o nome do livro que deseja remover:"
         nome <- getLine
         let aa = remove nome
         print aa
     else if( op=="3") then do
         putStrLn "ALUGUEL DE LIVROS - Digite o nome do livro que deseja remover:"
         nome <- getLine
         let aa = remove nome
         print aa
     else do
           a <- readFile "autores.txt"
           print a
           putStrLn "BUSCA DE LIVRO - Digite nome do livro a ser procurado:"
     main


