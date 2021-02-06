halve :: [a] -> ([a],[a])
halve [] = error "list empty"
halve xs | even (length xs) = splitAt ((length xs) `div` 2) xs
         | otherwise        = error "list not even"