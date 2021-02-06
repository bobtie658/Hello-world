all :: (a -> Bool) -> [a] -> Bool
all x xs = foldr (f) True xs
    where f = \w y -> (x w) && y

any :: (a -> Bool) -> [a] -> Bool
any x xs = foldr (f) False xs
    where f = \w y -> (x w) || y

takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile x xs = foldr (f) [] xs
    where f w y | x w  = w : y
                | otherwise = []

dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile x xs = foldr (f) [] xs
    where f w y | x w  = y
                | otherwise = xs