encrypt :: Int -> String -> (String , String -> String)
encrypt y x = (enc y x , \z -> enc (-y) z)
    where enc :: Int -> String -> String
          enc _ [] = []
          enc y (x:xs) = (toEnum((fromEnum x)+y)) : enc y xs