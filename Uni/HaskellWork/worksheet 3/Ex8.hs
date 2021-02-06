euclid :: Int -> Int -> Int
euclid x y | (max x y) `mod` (min x y) == 0 = min x y
           | otherwise      = euclid ((max x y) `mod` (min y x)) (min x y)