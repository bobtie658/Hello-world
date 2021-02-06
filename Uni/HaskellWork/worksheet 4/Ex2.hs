dec2Int :: [Int] -> Int
dec2Int xs = read $ foldr (f) [] xs :: Int
    where f = \z y -> show z ++ y