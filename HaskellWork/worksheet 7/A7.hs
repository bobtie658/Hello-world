{-# LANGUAGE DeriveGeneric #-}
--TEMPLATE FILE FOR COURSEWORK 1 for COMP2209
--Julian Rathke, Oct 2019

--EXERCISE A7 ONLY

--CONTAINS FUNCTION REQIURED FOR COMPILATION AGAINST THE TEST SUITE
--MODIFY THE FUNCTION DEFINITIONS WITH YOUR OWN SOLUTIONS
--IMPORTANT : DO NOT MODIFY ANY FUNCTION TYPES


module Exercises (evalInst,Instruction(..),Stack,SMProg) where

import GHC.Generics (Generic,Generic1)
import Control.DeepSeq


data Instruction = Add | Sub | Mul | Div | Dup | Pop deriving (Eq,Ord,Show,Generic)
type Stack = [Maybe Int]
type SMProg = [Instruction] 

instance NFData (Instruction)

-- Exercise A7
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