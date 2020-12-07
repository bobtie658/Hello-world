{-# LANGUAGE DeriveGeneric #-}
--TEMPLATE FILE FOR COURSEWORK 1 for COMP2209
--Julian Rathke, Oct 2019

--EXERCISE A8 ONLY

--CONTAINS FUNCTION REQIURED FOR COMPILATION AGAINST THE TEST SUITE
--MODIFY THE FUNCTION DEFINITIONS WITH YOUR OWN SOLUTIONS
--IMPORTANT : DO NOT MODIFY ANY FUNCTION TYPES


module Exercises (findMaxReducers,Instruction(..),Stack,SMProg) where

import GHC.Generics (Generic,Generic1)
import Control.DeepSeq


data Instruction = Add | Sub | Mul | Div | Dup | Pop deriving (Eq,Ord,Show,Generic)
type Stack = [Maybe Int]
type SMProg = [Instruction]

instance NFData (Instruction)

-- Exercise A8

findMaxReducers :: Stack -> [SMProg]
findMaxReducers [] = []
findMaxReducers [x] = [[]]
findMaxReducers xs = simplify $ start xs []
    where start :: Stack -> SMProg -> [(Maybe Int,SMProg)]
          start [x] j = [(x,j)]
          start (Nothing : Just 0 : xs) j = start (Just 0:xs) (j++[Pop]) ++ start (Nothing:xs) (j++[Add]) ++ start (Nothing:xs) (j++[Sub]) ++ start (Nothing:xs) (j++[Mul]) ++ start (Nothing:xs) (j++[Div])
          start (Nothing : xs) j = start xs (j++[Pop])
          start (Just 0 : Just 0 : xs) j = start (Just 0:xs) (j++[Add]) ++ start (Just 0:xs) (j++[Sub]) ++ start (Just 0:xs) (j++[Pop]) ++ start (Just 0:xs) (j++[Mul]) ++ start (Nothing:xs) (j++[Div])
          start (Just 0 : Just x2 : xs) j = start (Just x2:xs) (j++[Add]) ++ start (Just x2:xs) (j++[Pop]) ++ start (Just (-x2):xs) (j++[Sub])
          start (Just x1 : Just 0 : xs) j = start (Just x1:xs) (j++[Add]) ++ start (Just x1:xs) (j++[Sub])
          start (Just x1 : Just 1 : xs) j | x1>0 = start (Just (x1+1):xs) (j++[Add])
                                          | x1<0 = start (Just (x1-1):xs) (j++[Sub])
          start (Just 1 : Just x2 : xs) j | x2>0 = start (Just (x2+1):xs) (j++[Add])
                                          | x2<0 = start (Just (1-x2):xs) (j++[Sub]) ++ start (Just x2 : xs) (j++[Mul])
          start (Just x1 : Just (-1) : xs) j | x1>0 = start (Just (x1+1):xs) (j++[Sub])
          start (Just (-1) : Just x2 : xs) j | x2>0 = start (Just (-1-x2):xs) (j++[Sub]) ++ start (Just x2:xs) (j++[Pop])
          start (Just x1 : Just x2 : xs) j | x1>0 && x2>0 = start (Just (x1*x2):xs) (j++[Mul])
                                           | x1<0 && x2>0 = start (Just (x1*x2):xs) (j++[Mul]) ++ start (Just (x1-x2):xs) (j++[Sub]) ++ start (Just x2:xs) (j++[Pop])
                                           | x1>0 && x2<0 = start (Just (x1*x2):xs) (j++[Mul]) ++ start (Just (x1-x2):xs) (j++[Sub])
                                           | x1<0 && x2<0 = start (Just (x1*x2):xs) (j++[Mul]) ++ start (Just (x1+x2):xs) (j++[Add])
          simplify :: [(Maybe Int, SMProg)] -> [SMProg]
          simplify xs = separate xs (maxValue xs (-2147483648))
          maxValue :: [(Maybe Int, SMProg)] -> Int -> Int
          maxValue [] y = y
          maxValue ((Nothing,_):xs) y = maxValue xs y
          maxValue ((Just x,_):xs) y | x>y = maxValue xs x
                                     | otherwise = maxValue xs y
          separate :: [(Maybe Int, SMProg)] -> Int -> [SMProg]
          separate [] _ = []
          separate ((Nothing,_):xs) z = separate xs z
          separate ((Just x,y):xs) z | x==z = y : separate xs z
                                     | otherwise = separate xs z