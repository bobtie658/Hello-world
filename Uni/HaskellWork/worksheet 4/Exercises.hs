{-# LANGUAGE DeriveGeneric #-}
--SKELETON FILE FOR HANDIN 2 OF COURSEWORK 1 for COMP2209, 2020
--CONTAINS ALL FUNCTIONS REQIURED FOR COMPILATION AGAINST THE TEST SUITE
--MODIFY THE FUNCTION DEFINITIONS WITH YOUR OWN SOLUTIONS
--IMPORTANT : DO NOT MODIFY ANY FUNCTION TYPES
--Julian Rathke, Oct 2020

module Exercises (neighbours,findBonding,insertFromCurrentNode,VTree(..),Direction(..),Trail(..),Zipper(..)) where

-- The following two  imports are needed for testing, do not delete
import GHC.Generics (Generic,Generic1)
import Control.DeepSeq

import Data.List


type Point a = (a,a)
type Metric a = (Point a) -> (Point a) -> Double

-- Exercise A4

neighbours ::  Int -> Metric a -> Point a -> [Point a] -> [Point a]
neighbours k d p [] = []
neighbours k _ _ _ | k < 0 = error "input too small"
neighbours k d p xs = lowest (start d p xs) k
    where start :: Metric a -> Point a -> [Point a] -> [(Double,Point a)]
          start d p [] = []
          start d p (x:xs) = (d p x,x) : start d p xs
          lowest :: [(Double,Point a)] -> Int -> [Point a]
          lowest [] k = []
          lowest xs k | k > 0     = snd (minim xs) : lowest (delete (minim xs) xs) (k-1)
                      | otherwise = []
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

-- Exercise A6

data VTree a = Leaf | Node (VTree a) a Int (VTree a) deriving (Eq,Show,Generic,Generic1)
data Direction a = L a Int (VTree a) | R a Int (VTree a) deriving (Eq,Show,Generic,Generic1)
type Trail a = [Direction a]
type Zipper a = (VTree a, Trail a)

instance NFData a => NFData (VTree a)
instance NFData a => NFData (Direction a)

insertFromCurrentNode :: Ord a => a -> Zipper a -> Zipper a
insertFromCurrentNode v t = initStart v $ goRoot t v
    where start :: Ord a => a -> Zipper a -> Zipper a
          start v (Leaf, t) = (Node (Leaf) v 1 (Leaf),t)
          start v (Node l a n r, t) | a == v = (Node l a (n+1) r, t)
                                    | a > v  = start v (l, (L a (n+1) r):t)
                                    | a < v  = start v (r, (R a (n+1) l):t)
          initStart :: Ord a => a -> Zipper a -> Zipper a
          initStart v (Leaf, t) = (Node (Leaf) v 1 (Leaf),t)
          initStart v (Node l a n r, t) | a == v = (Node l a n r, t)
                                        | a > v  = start v (l, (L a n r):t)
                                        | a < v  = start v (r, (R a n l):t)
          goRoot :: Eq a => Zipper a -> a -> Zipper a
          goRoot (t,[]) _ = (t,[])
          goRoot (Node l a n r,t) v | v==a = (Node l a n r,t)
          goRoot (l, (L a n r):tr) v = goRoot (Node l a (n+1) r,tr) v
          goRoot (r, (R a n l):tr) v = goRoot (Node l a (n+1) r,tr) v

mkTree :: Ord a => [a] -> Zipper a
mkTree = foldl (\z -> \x -> insertFromCurrentNode x z) (Leaf,[])
