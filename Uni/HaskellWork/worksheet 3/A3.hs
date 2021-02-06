--TEMPLATE FILE FOR COURSEWORK 1 for COMP2209
--Julian Rathke, Oct 2020

--EXERCISE A3 ONLY

--CONTAINS FUNCTION REQIURED FOR COMPILATION AGAINST THE TEST SUITE
--MODIFY THE FUNCTION DEFINITIONS WITH YOUR OWN SOLUTIONS
--IMPORTANT : DO NOT MODIFY ANY FUNCTION TYPES


module Exercises (amSplit) where

-- Exercise A3
--amSplit goes through and cuts the list at each point it becomes monotone
--then places them within another list
amSplit :: Ord a => [a] -> [[a]]
amSplit [] = []
amSplit xs = eachSubset xs : amSplit (removeList xs (eachSubset xs))

--used to reduce the master list so it does not include elements already tested
    where removeList :: [a] -> [a] -> [a]
          removeList x [] = x
          removeList [] y = y
          removeList x y = removeList (tail x) (tail y)

--the elements are zipped with the element before it, it is then tested
          eachSubset :: Ord a => [a] -> [a]
          eachSubset [] = []
          eachSubset [a] = [a]
          eachSubset p@(x:y:xs) | x == y    = x : eachSubset (tail p)
                                | x > y     = x : smaller (zip [l | l <- tail p] [k | k <- p])
                                | otherwise = x : larger (zip [l | l <- tail p] [k | k <- p])

--larger and smaller mutually call each other recursively to test the elements
--the list is cut off at the point it becomes monotone
          larger :: Ord a => [(a,a)] -> [a]
          larger [] = []
          larger ((x,y):xs) | x == y    = x : larger xs
                            | x > y     = x : smaller xs
                            | otherwise = []

          smaller :: Ord a => [(a,a)] -> [a]
          smaller [] = []
          smaller ((x,y):xs) | x == y    = x : smaller xs
                             | x  < y    = x : larger xs
                             | otherwise = []