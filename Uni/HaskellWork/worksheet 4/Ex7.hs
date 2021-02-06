data Tree a = Leaf | Node (Tree a) a (Tree a) deriving Show

toTree :: Ord a => [a] -> Tree a
toTree [] = Leaf
toTree ys = start (quicksort ys)
     where start [] = Leaf
           start xs = Node (toTree (fst (splitmid xs))) (xs!!((length xs) `div` 2)) (toTree (tail(snd (splitmid xs))))
           splitmid xs = splitAt ((length xs) `div` 2) xs

quicksort :: Ord a => [a] -> [a]
quicksort []     = []
quicksort (p:xs) = (quicksort lesser) ++ [p] ++ (quicksort greater)
    where
        lesser  = filter (< p) xs
        greater = filter (>= p) xs