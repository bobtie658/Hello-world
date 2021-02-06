--TEMPLATE FILE FOR COURSEWORK 1 for COMP2209
--Julian Rathke, Oct 2019

--EXERCISE A5 ONLY

--CONTAINS FUNCTION REQIURED FOR COMPILATION AGAINST THE TEST SUITE
--MODIFY THE FUNCTION DEFINITIONS WITH YOUR OWN SOLUTIONS
--IMPORTANT : DO NOT MODIFY ANY FUNCTION TYPES


module Exercises (findBonding) where

-- Exercise A5
findBonding :: Eq a => (a -> a -> Bool) -> [a] -> Maybe [(a,a)]
findBonding _ xs | odd (length xs) = Nothing
findBonding _ [] = Just []
findBonding k xs = solve (solution $ powerset xs k) xs
    where
          powerset :: Eq a => [a] -> (a -> a -> Bool) -> [[(a,a)]]
          powerset [a] _ = []
          powerset (x:xs) k | powerset2 x xs k /= [] = powerset2 x xs k : powerset xs k
                            | otherwise              = powerset xs k
          powerset2 :: a -> [a] -> (a -> a -> Bool) -> [(a,a)]
          powerset2 _ [] _ = []
          powerset2 y (x:xs) k | k y x     = (y,x) : powerset2 y xs k
                               | otherwise = powerset2 y xs k
          test :: Eq a => [(a,a)] -> [a] -> Bool
          test xs a = foldr (f) True a
              where f = \x y -> ((testing 0 0 [] [] x xs) && y)
          testing :: Eq a => Int -> Int -> [a] -> [a] -> a -> [(a,a)] -> Bool
          testing x y xs ys _ [] | x==1 && y==1 && xs==ys = True
                                 | otherwise              = False
          testing x y xs ys z ((a,b):zs) | z==a      = testing (x+1) y (b:xs) ys z zs
                                         | z==b      = testing x (y+1) xs (a:ys) z zs
                                         | otherwise = testing x y xs ys z zs
          solution :: Eq a => [[(a,a)]] -> [[(a,a)]]
          solution ([]:_) = []
          solution [] = [[]]
          solution (((a,b):xs):ys) = solution (xs:ys) ++ map ([(a,b),(b,a)]++) (solution (delete ys (a,b)))
          delete :: Eq a => [[(a,a)]] -> (a,a) -> [[(a,a)]]
          delete [] _ = []
          delete [[]] _ = []
          delete (((x,y):[]):xs) (a,b) | a==x || b==x || a==y || b==y = delete xs (a,b)
          delete (((x,y):ys):xs) (a,b) | b==x || a==x = delete xs (a,b)
                                       | otherwise = deleteHigher ((x,y):ys) (a,b) : delete xs (a,b)
          deleteHigher :: Eq a => [(a,a)] -> (a,a) -> [(a,a)]
          deleteHigher [] _ = []
          deleteHigher ((a,b):xs) (x,y) | b==x || b==y = deleteHigher xs (x,y)
                                    | otherwise    = (a,b) : deleteHigher xs (x,y)
          solve :: Eq a => [[(a,a)]] -> [a] -> Maybe [(a,a)]
          solve [] _ = Nothing
          solve (x:xs) a | length (x) /= length a = solve xs a
                         | test x a  = Just x
                         | otherwise = solve xs a
