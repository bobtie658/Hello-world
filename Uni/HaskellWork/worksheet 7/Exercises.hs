{-# LANGUAGE DeriveGeneric #-}
--SOLUTIONS TO COURSEWORK 1 for COMP2209, 2019
--DO NOT DISTRIBUTE
--Julian Rathke, Oct 2019

module Exercises (evalInst,findMaxReducers,isPossiblePower,Instruction(..),Stack,SMProg) where

import GHC.Generics (Generic,Generic1)
import Control.DeepSeq


-- Exercise A7
data Instruction = Add | Sub | Mul | Div | Dup | Pop deriving (Eq,Ord,Show,Generic)
type Stack = [Maybe Int]
type SMProg = [Instruction] 

instance NFData (Instruction)

evalInst :: Stack -> SMProg -> Stack
evalInst xs [] = xs
evalInst [] _ = error "empty stack"
evalInst (Just x : Just y : xs) (Add:is) = evalInst ((Just (x+y)) : xs) is
evalInst (_:_:xs) (Add:is) = evalInst (Nothing : xs) is
evalInst [x] (Add:is) = error "stack too small"
evalInst (Just x : Just y : xs) (Sub:is) = evalInst (Just (x-y) : xs) is
evalInst (_:_:xs) (Sub:is) = evalInst (Nothing : xs) is
evalInst [x] (Sub:is) = error "stack too small"
evalInst (Just x : Just y : xs) (Mul:is) = evalInst (Just (x*y) : xs) is
evalInst (_:_:xs) (Mul:is) = evalInst (Nothing : xs) is
evalInst [x] (Mul:is) = error "stack too small"
evalInst (_: Just 0 :xs) (Div:is) = evalInst (Nothing : xs) is
evalInst (Just x : Just y : xs) (Div:is) = evalInst (Just (x `div` y) : xs) is
evalInst [x] (Div:is) = error "stack too small"
evalInst (_:_:xs) (Div:is) = evalInst (Nothing : xs) is
evalInst xs (Dup:is) = evalInst (head xs : xs) is
evalInst (x:xs) (Pop:is) = evalInst xs is


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