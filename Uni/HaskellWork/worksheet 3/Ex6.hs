positions :: Eq a => a -> [a] -> [Int]
positions x xs = find x (zip xs [0..])
    where find :: Eq a => a -> [(a,b)] -> [b]
          find k t = [v | (k',v) <- t, k==k']