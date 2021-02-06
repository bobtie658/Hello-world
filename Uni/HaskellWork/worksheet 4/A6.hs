{-# LANGUAGE DeriveGeneric #-}

--TEMPLATE FILE FOR COURSEWORK 1 for COMP2209
--Julian Rathke, Oct 2019

--EXERCISE A6 ONLY

--CONTAINS FUNCTION REQIURED FOR COMPILATION AGAINST THE TEST SUITE
--MODIFY THE FUNCTION DEFINITIONS WITH YOUR OWN SOLUTIONS
--IMPORTANT : DO NOT MODIFY ANY FUNCTION TYPES

module Exercises (insertFromCurrentNode,VTree(..),Direction(..),Trail(..),Zipper(..)) where

-- The following two imports are needed for testing, do not delete
import GHC.Generics (Generic,Generic1)
import Control.DeepSeq 

data VTree a = Leaf | Node (VTree a) a Int (VTree a) deriving (Eq,Show,Generic,Generic1)
data Direction a = L a Int (VTree a) | R a Int (VTree a) deriving (Eq,Show,Generic,Generic1)
type Trail a = [Direction a]
type Zipper a = (VTree a, Trail a)

instance NFData a => NFData (VTree a)
instance NFData a => NFData (Direction a)


-- Exercise A6
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
