luhn :: [Int] -> Bool
luhn xs = (y.sum.odd.reverse) xs
    where odd [] = []
          odd (x:xs) = x : even xs
          even [] = []
          even (x:xs) | x<5       = 2*x : odd xs
                      | otherwise = (2*x)-9 : odd xs
          y = \z -> (z `mod` 10) == 0