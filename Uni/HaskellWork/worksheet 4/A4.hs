--TEMPLATE FILE FOR COURSEWORK 1 for COMP2209
--Julian Rathke, Oct 2019

--EXERCISE A4 ONLY

--CONTAINS FUNCTION REQIURED FOR COMPILATION AGAINST THE TEST SUITE
--MODIFY THE FUNCTION DEFINITIONS WITH YOUR OWN SOLUTIONS
--IMPORTANT : DO NOT MODIFY ANY FUNCTION TYPES


module Exercises (neighbours) where

import Data.List

type Point a = (a,a)
type Metric a = (Point a) -> (Point a) -> Double

-- Exercise A4

neighbours ::  Int -> Metric a -> Point a -> [Point a] -> [Point a]
neighbours k d p [] = []
neighbours k d p xs = lowest (start d p xs) k
    where start :: Metric a -> Point a -> [Point a] -> [(Double,Point a)]
          start d p [] = []
          start d p (x:xs) = (d p x,x) : start d p xs
          lowest :: [(Double,Point a)] -> Int -> [Point a]
          lowest [] k = []
          lowest xs k | k > 0 = snd (minim xs) : lowest (delete (minim xs) xs) (k-1)
          minim :: [(Double,Point a)] -> (Double,Point a)
          minim [(a,b)] = (a,b)
          minim ((a,b):xs) = min (a,b) (minim xs)
          min :: (Double,Point a) -> (Double,Point a) -> (Double,Point a)
          min (a,b) (x,y) | a > x  = (x,y)
                          | a < x  = (a,b)
                          | a == x = (a,b)
          delete :: (Double,Point a) -> [(Double,Point a)] -> [(Double,Point a)]
          delete _ [] = []
          delete (a,(b,c)) ((x,(y,z)):xs) | a==x      = xs
                                          | otherwise = (x,(y,z)) : delete (a,(b,c)) xs