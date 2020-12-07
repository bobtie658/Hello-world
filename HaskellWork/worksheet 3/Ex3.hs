replicate :: Int -> a -> [a]
replicate n x = [x | y <- [1..n]]