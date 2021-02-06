pyths :: Int -> [(Int,Int,Int)]
pyths n = [(x,y,z) | z <- [1..n], y <- [1..n], x <- [1..n], x^2 + y^2 == z^2]