perfect :: Int -> [Int]
perfect n = [x | x <- [1..n], sum (factors x) - x == x]
    where factors n = [x | x <- [1..n], n `mod` x == 0]