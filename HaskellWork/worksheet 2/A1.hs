--TEMPLATE FILE FOR COURSEWORK 1 for COMP2209
--Julian Rathke, Oct 2020

--EXERCISE A1 ONLY

--CONTAINS FUNCTION REQIURED FOR COMPILATION AGAINST THE TEST SUITE
--MODIFY THE FUNCTION DEFINITIONS WITH YOUR OWN SOLUTIONS
--IMPORTANT : DO NOT MODIFY ANY FUNCTION TYPES


module Exercises (histogram) where

-- Exercise A1
histogram :: Int -> [Int] -> [Int]
histogram _ [] = error "empty set"
histogram n xs | n < 1     = error "increment value < 1"
               | otherwise = histogramCalculator n xs
    where initialNum = n
-- histogramCalculator does the recusion as firstNum has to stay constant
          histogramCalculator :: Int -> [Int] -> [Int]
          histogramCalculator n [] = []
          histogramCalculator n xs = (length (histogramSearch n xs)) : histogramCalculator (n+initialNum) (searchDelete (histogramSearch n xs) xs)
-- histogramSearch is used to find the numbers in a list that are smaller then a given integer
          histogramSearch :: Int -> [Int] -> [Int]
          histogramSearch _ [] = []
          histogramSearch n (x:xs) | x < n     = x:histogramSearch n xs
                                   | otherwise = histogramSearch n xs
-- searchDelete removes the intersection between two lists
          searchDelete :: [Int] -> [Int] -> [Int]
          searchDelete [] ys = ys
          searchDelete (x:xs) ys = searchDelete xs (delete x ys)
-- delete removes the first instance of a given integer from a list
          delete :: Int -> [Int] -> [Int]
          delete x [] = []
          delete x (y:ys) | y == x    = ys
                          | otherwise = y : (delete x ys)