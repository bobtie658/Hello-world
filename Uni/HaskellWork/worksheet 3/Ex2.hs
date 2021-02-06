grid :: Int -> Int -> [(Int,Int)]
grid y z = [(x,n) | x <- [0..y], n <- [0..z]]

square :: Int -> [(Int,Int)]
square n = [x | x <- grid n n, fst x /= snd x]