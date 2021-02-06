{-# LANGUAGE DeriveGeneric #-}
--TEMPLATE FILE FOR COURSEWORK 1 for COMP2209
--Julian Rathke, Oct 2019

--EXERCISE A9 ONLY

--CONTAINS FUNCTION REQIURED FOR COMPILATION AGAINST THE TEST SUITE
--MODIFY THE FUNCTION DEFINITIONS WITH YOUR OWN SOLUTIONS
--IMPORTANT : DO NOT MODIFY ANY FUNCTION TYPES


module Exercises (isPossiblePower,Instruction(..),Stack,SMProg) where

import GHC.Generics (Generic,Generic1)
import Control.DeepSeq


data Instruction = Add | Sub | Mul | Div | Dup | Pop deriving (Eq,Ord,Show,Generic)
type Stack = [Maybe Int]
type SMProg = [Instruction] 

instance NFData (Instruction)

-- Exercise A9

isPossiblePower :: Int -> Int -> Bool
isPossiblePower x y | x<1 || y<0 = error "input too small"
isPossiblePower x y = subset x (power y)
    where power :: Int -> [Int]
          power 0 = [1]
          power x = power2 x [1]
          power2 :: Int -> [Int] -> [Int]
          power2 0 [x] = [x]
          power2 0 (x:y:xs) = power2 0 (x+y:xs)
          power2 z [x] = power2 (z-1) [x,x]
          power2 z (x:y:xs) = power2 z (x+y:xs) ++ power2 (z-1) (x:x:y:xs)
          subset :: Int -> [Int] -> Bool
          subset x xs | (length $ filter (x==) xs) > 0 = True
                      | otherwise = False