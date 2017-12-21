cadastra:: String -> String -> String -> IO()
cadastra nome autor editora = do
 appendFile "titulos.txt" (nome++ "*")
 appendFile "autores.txt" (autor ++ "*")
 appendFile "editora.txt" (editora ++ "*")


remove :: String -> Bool
remove livro = True

avalia :: String -> Int -> String
avalia nome nota = "aa"


main = do 
     print "PUTA"
     op <- getLine
     if (op == "1") then do
         putStrLn "CADASTRO DE LIVRO - Digite o nome do filme que deseja cadastrar:"
         nome <- getLine
         autor<- getLine
         editora <- getLine
         cadastra nome autor editora
         
     else if( op == "2") then do
         putStrLn "REMOÇÃO DE LIVRO - Digite o nome do filme que deseja remover:"
         nome <- getLine
         let aa = remove nome
         print aa
     else if( op=="3") then do
         putStrLn "AVALIAÇÃO DE LIVRO - Digite o nome e a nota do filme que deseja avaliar:"
         nome <- getLine 
         nota <- getLine
         let a = avalia nome (read nota)
         print a
     else if( op== "4") then do
         putStrLn "ALTERAÇÃO DE NOTA DE AVALIAÇÃO - Digite a nova nota de avaliação:" 
         nome <- getLine
         nota <- getLine 
         let o = avalia nome (read nota)
         print o          
     else do
           a <- readFile "autores.txt"
           print a
           putStrLn "BUSCA DE LIVRO - Digite nome do filme a ser procurado:"
     main
