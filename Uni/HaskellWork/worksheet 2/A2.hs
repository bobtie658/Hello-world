--TEMPLATE FILE FOR COURSEWORK 1 for COMP2209
--Julian Rathke, Oct 2020

--EXERCISE A2 ONLY

--CONTAINS FUNCTION REQIURED FOR COMPILATION AGAINST THE TEST SUITE
--MODIFY THE FUNCTION DEFINITIONS WITH YOUR OWN SOLUTIONS
--IMPORTANT : DO NOT MODIFY ANY FUNCTION TYPES


module Exercises (approxPi) where

-- Exercise A2
approxPi :: Int -> Double
approxPi n | n > 0     = 2*(sum (applyCalc [0..(n-1)]))
           | otherwise = error "input > 1"
-- factorial function works as expected
    where factorial :: Integer -> Integer
          factorial x = product [1..x]
-- only odd numbers will be used on this function, therefore only the odd part is added
          doubleFactorial :: Integer -> Integer
          doubleFactorial x = product (filter odd [1..x])
-- calculation for each value of k
          instanceCalc :: Int -> Double
          instanceCalc 0 = 1
          instanceCalc x = fromIntegral (factorial (toInteger x)) / fromIntegral (doubleFactorial (2*(toInteger x) + 1))
-- applies the function to each element in the list
          applyCalc :: [Int] -> [Double]
          applyCalc [] = []
          applyCalc (x:xs) = (instanceCalc x) : applyCalc xs