cadastra:: String -> [String]
cadastra filme = [filme]

remove :: String -> Bool
remove livro = True

avalia :: String -> Int -> String
avalia nome nota = "aa"


main = do 

     op <- getLine
     if (op == "1") then do
         putStrLn "CADASTRO DE LIVRO - Digite o nome do filme que deseja cadastrar:"
         nome <- getLine
         let resposta = cadastra nome
         print resposta
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
           putStrLn "BUSCA DE LIVRO - Digite nome do filme a ser procurado:"
		   
