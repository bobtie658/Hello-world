unfold :: (a -> Bool) -> (a -> b) -> (a -> a) -> a -> [b]
unfold p h t x | p x       = []
               | otherwise = h x : unfold p h t (t x)

int2bin :: Int -> [Int]
int2bin x = unfold p h t (x,2^(round (logBase 2 (fromIntegral x)) + 1))
    where p = \(_,z) -> z == 0
          h (y,z) | y < z     = 0
                  | otherwise = 1
          t (y,z) | z == 1    = (y,0)
                  | y < z     = (y,z `div` 2)
                  | otherwise = (y-z,z `div` 2)

chop :: String -> Int -> [String]
chop xs x = unfold p h t xs
    where p = \z -> z == []
          h = \z -> take x z
          t = \z -> drop x z

map :: Eq a => (a -> b) -> [a] -> [b]
map x xs = unfold p h t xs
    where p = \z -> z == []
          h = \z -> x (head z)
          t z = tail z

iterate :: (a -> a) -> a -> [a]
iterate x y = y : unfold p h t y
     where p = \z -> False
           h = \z -> x z
           t = \z -> x z