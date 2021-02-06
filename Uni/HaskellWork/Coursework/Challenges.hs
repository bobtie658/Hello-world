{-# LANGUAGE DeriveGeneric #-}
-- comp2209 Functional Programming Challenges
-- (c) University of Southampton 2020
-- Skeleton code to be updated with your solutions
-- The dummy functions here simply return an arbitrary value that is usually wrong 

-- DO NOT MODIFY THE FOLLOWING LINES OF CODE
module Challenges (WordSearchGrid,Placement,Posn,Orientation(..),solveWordSearch, createWordSearch,
    LamMacroExpr(..),LamExpr(..),prettyPrint, parseLamMacro,
    cpsTransform,innerRedn1,outerRedn1,compareInnerOuter) where

-- Import standard library and parsing definitions from Hutton 2016, Chapter 13
-- We import System.Random - make sure that your installation has it installed - use stack ghci and stack ghc
import Data.Char
import Parsing
import Control.Monad
import Data.List
import GHC.Generics (Generic,Generic1)
import Control.DeepSeq
import System.IO
import System.Random

instance NFData Orientation
instance NFData LamMacroExpr
instance NFData LamExpr

-- types for Part I
type WordSearchGrid = [[ Char ]]
type Placement = (Posn,Orientation)
type Posn = (Int,Int)
data Orientation = Forward | Back | Up | Down | UpForward | UpBack | DownForward | DownBack deriving (Eq,Ord,Show,Read,Generic)

-- types for Parts II and III
data LamMacroExpr = LamDef [ (String,LamExpr) ] LamExpr deriving (Eq,Show,Read,Generic)
data LamExpr = LamMacro String | LamApp LamExpr LamExpr  |
               LamAbs Int LamExpr  | LamVar Int deriving (Eq,Show,Read,Generic)

-- END OF CODE YOU MUST NOT MODIFY

-- ADD YOUR OWN CODE HERE

-- Challenge 1 --

solveWordSearch :: [String] -> WordSearchGrid -> [(String,Maybe Placement)]
solveWordSearch x y | length x == 0 = []
                    | length y == 0 = map (\z -> (z,Nothing)) x
                    | (length $ y!!0) == 0 = map (\z -> (z,Nothing)) x
                    | length y /= (length $ y!!0) = error "Input grid is not square" --function cannot work if there are no strings to search for or if the grid is not square
                    | otherwise = map (search y (0,0)) x
--search function will check every direction at the current location for the string, then move to the next point in the grid if it is not found here
    where search :: WordSearchGrid -> Posn -> String -> (String,Maybe Placement)
          search _ _ "" = ("",Nothing)
          search y (-1,-1) z = (z,Nothing)
          search y x@(x1,x2) z@(zi:zs) | y!!x2!!x1 /= zi = search y (iterate x y) z
                                       | searchUp y (x1,x2-1) zs = (z,Just (x,Up))
                                       | searchDown y (x1,x2+1) zs = (z,Just (x,Down))
                                       | searchRight y (x1+1,x2) zs = (z,Just (x,Forward))
                                       | searchLeft y (x1-1,x2) zs = (z,Just (x,Back))
                                       | searchUpRight y (x1+1,x2-1) zs = (z,Just (x,UpForward))
                                       | searchUpLeft y (x1-1,x2-1) zs = (z,Just (x,UpBack))
                                       | searchDownRight y (x1+1,x2+1) zs = (z,Just (x,DownForward))
                                       | searchDownLeft y (x1-1,x2+1) zs = (z,Just (x,DownBack))
                                       | otherwise = search y (iterate x y) z
--these search functions are pretty much the same, they all check a direction and return True if the word is there
          searchUp :: WordSearchGrid -> Posn -> String -> Bool
          searchUp _ _ [] = True
          searchUp y (x1,x2) (zi:zs) | x2<length zs = False
                                     | y!!x2!!x1 == zi = searchUp y (x1,x2-1) zs
                                     | otherwise = False
          searchDown :: WordSearchGrid -> Posn -> String -> Bool
          searchDown _ _ [] = True
          searchDown y (x1,x2) (zi:zs) | length y -x2<=length zs = False
                                       | y!!x2!!x1 == zi = searchDown y (x1,x2+1) zs
                                       | otherwise = False
          searchRight :: WordSearchGrid -> Posn -> String -> Bool
          searchRight _ _ [] = True
          searchRight y (x1,x2) (zi:zs) | length y -x1<=length zs = False
                                        | y!!x2!!x1 == zi = searchRight y (x1+1,x2) zs
                                        | otherwise = False
          searchLeft :: WordSearchGrid -> Posn -> String -> Bool
          searchLeft _ _ [] = True
          searchLeft y (x1,x2) (zi:zs) | x1<length zs = False
                                       | y!!x2!!x1 == zi = searchLeft y (x1-1,x2) zs
                                       | otherwise = False
          searchUpRight :: WordSearchGrid -> Posn -> String -> Bool
          searchUpRight _ _ [] = True
          searchUpRight y (x1,x2) (zi:zs) | x2<length zs = False
                                          | length y -x1<=length zs = False
                                          | y!!x2!!x1 == zi = searchUpRight y (x1+1,x2-1) zs
                                          | otherwise = False
          searchUpLeft :: WordSearchGrid -> Posn -> String -> Bool
          searchUpLeft _ _ [] = True
          searchUpLeft y (x1,x2) (zi:zs) | x2<length zs = False
                                         | x1<length zs = False
                                         | y!!x2!!x1 == zi = searchUpLeft y (x1-1,x2-1) zs
                                         | otherwise = False
          searchDownRight :: WordSearchGrid -> Posn -> String -> Bool
          searchDownRight _ _ [] = True
          searchDownRight y (x1,x2) (zi:zs) | length y -x2<=length zs = False
                                            | length y -x1<=length zs = False
                                            | y!!x2!!x1 == zi = searchDownRight y (x1+1,x2+1) zs
                                            | otherwise = False
          searchDownLeft :: WordSearchGrid -> Posn -> String -> Bool
          searchDownLeft _ _ [] = True
          searchDownLeft y (x1,x2) (zi:zs) | length y -x2<=length zs = False
                                           | x1<length zs = False
                                           | y!!x2!!x1 == zi = searchDownLeft y (x1-1,x2+1) zs
                                           | otherwise = False
          iterate :: Posn -> WordSearchGrid -> Posn --helper function which moves the current marker one left to right, top to bottom
          iterate (x1,x2) y | x1+1==length y && x2+1==length y = (-1,-1)
                            | x1+1==length y = (0,x2+1)
                            | otherwise = (x1+1,x2)

-- Two examples for you to try out, the first of which is in the instructions

exGrid1'1 = [ "HAGNIRTSH" , "SACAGETAK", "GCSTACKEL","MGHKMILKI","EKNLETGCN","TNIRTLETE","IRAAHCLSR","MAMROSAGD","GIZKDDNRG" ] 
exWords1'1 = [ "HASKELL","STRING","STACK","MAIN","METHOD"]

exGrid1'2 = ["ROBREUMBR","AURPEPSAN","UNLALMSEE","YGAUNPYYP","NLMNBGENA","NBLEALEOR","ALRYPBBLG","NREPBEBEP","YGAYAROMR"]
exWords1'2 = [ "BANANA", "ORANGE", "MELON", "RASPBERRY","APPLE","PLUM","GRAPE" ]


-- Challenge 2 --

createWordSearch :: [String] -> Double -> IO WordSearchGrid
createWordSearch xs y | y>1 || y<=0 = error "Input double not within range 0 < n <= 1"
                      | xs == [] || xs == [[]] = return [] --the function will not work if no strings are inputted or if the ratio is less then 0 or greater then 1
createWordSearch xs y = do a <- makeGrid (getCharacters xs "") (floor $ sqrt $ (fromIntegral $ sum $ map length xs)/y) (-1)
                           if (solveable a xs) then createWordSearch xs y --if the randomly generated grid has any solveable parts, it will generate a new random grid, else, it will contrinue to implement the words
                           else implementWords xs a
    where makeGrid :: String -> Int -> Int -> IO WordSearchGrid --makeGrid creates a grid populated by random characters defined by an input string
          makeGrid "" _ _ = return []
          makeGrid xs y (-1) = makeGrid xs y y --the function requires a counter to keep track of how many rows have already been created, initially this is the same as the length of each string
          makeGrid xs y z = if (y>0) then do a <- randomString xs z
                                             b <- makeGrid xs (y-1) z
                                             return $ a : b
                                     else return []
          randomString :: [b] -> Int -> IO [b] --creates a string of random chars from input string of input length
          randomString xs y = if (y>0) then do a <- randomChar xs
                                               b <- randomString xs (y-1)
                                               return $ a : b
                                       else return []
          randomChar :: [b] -> IO b --selects a random char from a string
          randomChar xs = do a <- randomRIO (0,(length xs)-1)
                             return (xs!!a)
          getCharacters :: [String] -> String -> String --getCharacters is a function which returns a string of all the characters used in the input
          getCharacters [] ys = ys
          getCharacters (x:xs) ys = getCharacters xs $ checkSubstring ys x
          checkSubstring :: String -> String -> String --utility function of getCharacters
          checkSubstring ys [] = ys
          checkSubstring ys (x:xs) | Challenges.find x ys = checkSubstring ys xs
                                   | otherwise = checkSubstring (ys ++ [x]) xs
          solveable :: WordSearchGrid -> [String] -> Bool --solveable uses challenge 1 in order to check if the current grid is solveable or not
          solveable [] _ = False
          solveable x y = or $ solve $ solveWordSearch y x
          solve :: [(String,Maybe Placement)] -> [Bool] --utility frunction of solveable
          solve [] = []
          solve ((_,Nothing):xs) = False : solve xs
          solve ((_,Just _):xs) = [True]
--implement words repeats eachWord for every word to input
          implementWords :: [String] -> WordSearchGrid -> IO WordSearchGrid
          implementWords _ [] = return []
          implementWords xs grid = do (_,a) <- eachWord xs $ return ([],grid)
                                      return a
--the type ([Posn],WordSearchGrid) is used frequently here, the WordSearchGrid is the current up to date word search
--the [Posn] is a list of all of the positions where previously implemented words are stored, this is used when implementing new words as characters at these positions are not to be replaced
          eachWord :: [String] -> IO ([Posn],WordSearchGrid) -> IO ([Posn],WordSearchGrid)
          eachWord [] y = y
          eachWord ("":xs) y = eachWord xs y --if the string is empty, it will skip, this is to prevent errors from occuring in case of inputs like ["one","","three"]
          eachWord (x:xs) y = do a <- y
                                 b <- pickPositions x a
                                 b `deepseq` eachWord xs $ return b
--pickPositions picks at random a starting position for the next word, it then hands over to pickDirections
          pickPositions :: String -> ([Posn],WordSearchGrid) -> IO ([Posn],WordSearchGrid)
          pickPositions x@(xi:xs) (ys,y) = do a <- randomRIO (0,(length y -1))
                                              b <- randomRIO (0,(length y -1))
                                              if (canCharacter xi (a,b) ys y) then pickDirections (x,(a,b)) (ys,y) []
                                              else pickPositions x (ys,y)
--pickDirections randomises the order of numbers 1-8 and passes to tryDirection
          pickDirections :: (String,Posn) -> ([Posn],WordSearchGrid) -> [Int] -> IO ([Posn],WordSearchGrid)
          pickDirections x@(xi,pos) y z | length z == 8 = do if (b == ([],[])) then pickPositions xi y
                                                             else return b
                                        | otherwise = do a <- randomRIO (1,8)
                                                         if (Challenges.find a z) then pickDirections x y z
                                                         else pickDirections x y (z++[a])
                                            where b = tryDirection x y z
--in try direction, each direction will be tried in the order dictated by the random list of numbers 1-8, the word is placed in the first direction it can
--if none of the directions work, the word function will return ([],[]), which will prompt pickDirections to re call pickPositions to find a new start location for the word
          tryDirection :: (String,Posn) -> ([Posn], WordSearchGrid) -> [Int] -> ([Posn], WordSearchGrid)
          tryDirection (x,_) y [] = ([],[])
          tryDirection x y (1:z) | tryUp x y = up x y
          tryDirection x y (2:z) | tryDown x y = down x y
          tryDirection x y (3:z) | tryLeft x y = left x y
          tryDirection x y (4:z) | tryRight x y = right x y
          tryDirection x y (5:z) | tryUpLeft x y = upLeft x y
          tryDirection x y (6:z) | tryUpRight x y = upRight x y
          tryDirection x y (7:z) | tryDownLeft x y = downLeft x y
          tryDirection x y (8:z) | tryDownRight x y = downRight x y
          tryDirection x y (_:z) = tryDirection x y z
--these functions only trigger if the word can be put in a specific direction, it will input the word
          up :: (String,Posn) -> ([Posn],WordSearchGrid) -> ([Posn],WordSearchGrid)
          up (x,p) (ps,grid) = insertWord ps grid $ tryUp' x p
          down :: (String,Posn) -> ([Posn],WordSearchGrid) -> ([Posn],WordSearchGrid)
          down (x,p) (ps,grid) = insertWord ps grid $ tryDown' x p
          left :: (String,Posn) -> ([Posn],WordSearchGrid) -> ([Posn],WordSearchGrid)
          left (x,p) (ps,grid) = insertWord ps grid $ tryLeft' x p
          right :: (String,Posn) -> ([Posn],WordSearchGrid) -> ([Posn],WordSearchGrid)
          right (x,p) (ps,grid) = insertWord ps grid $ tryRight' x p
          upLeft :: (String,Posn) -> ([Posn],WordSearchGrid) -> ([Posn],WordSearchGrid)
          upLeft (x,p) (ps,grid) = insertWord ps grid $ tryUpLeft' x p
          upRight :: (String,Posn) -> ([Posn],WordSearchGrid) -> ([Posn],WordSearchGrid)
          upRight (x,p) (ps,grid) = insertWord ps grid $ tryUpRight' x p
          downLeft :: (String,Posn) -> ([Posn],WordSearchGrid) -> ([Posn],WordSearchGrid)
          downLeft (x,p) (ps,grid) = insertWord ps grid $ tryDownLeft' x p
          downRight :: (String,Posn) -> ([Posn],WordSearchGrid) -> ([Posn],WordSearchGrid)
          downRight (x,p) (ps,grid) = insertWord ps grid $ tryDownRight' x p
--all these try functions are nearly identical, they check if the word can be put in a direction from a start point, theres probably a better way to do this, but it works and isnt too slow
          tryUp :: (String,Posn) -> ([Posn],WordSearchGrid) -> Bool
          tryUp (xi,pos) (ys,y) = and $ map (\(x,z) -> canCharacter x z ys y) $ tryUp' xi pos
          tryUp' :: String -> Posn -> [(Char,Posn)]
          tryUp' [] _ = []
          tryUp' (x:xs) (y1,y2) = (x,(y1,y2)) : tryUp' xs (y1,y2-1)
          tryDown :: (String,Posn) -> ([Posn],WordSearchGrid) -> Bool
          tryDown (xi,pos) (ys,y) = and $ map (\(x,z) -> canCharacter x z ys y) $ tryDown' xi pos
          tryDown' :: String -> Posn -> [(Char,Posn)]
          tryDown' [] _ = []
          tryDown' (x:xs) (y1,y2) = (x,(y1,y2)) : tryDown' xs (y1,y2+1)
          tryLeft :: (String,Posn) -> ([Posn],WordSearchGrid) -> Bool
          tryLeft (xi,pos) (ys,y) = and $ map (\(x,z) -> canCharacter x z ys y) $ tryLeft' xi pos
          tryLeft' :: String -> Posn -> [(Char,Posn)]
          tryLeft' [] _ = []
          tryLeft' (x:xs) (y1,y2) = (x,(y1,y2)) : tryLeft' xs (y1-1,y2)
          tryRight :: (String,Posn) -> ([Posn],WordSearchGrid) -> Bool
          tryRight (xi,pos) (ys,y) = and $ map (\(x,z) -> canCharacter x z ys y) $ tryRight' xi pos
          tryRight' :: String -> Posn -> [(Char,Posn)]
          tryRight' [] _ = []
          tryRight' (x:xs) (y1,y2) = (x,(y1,y2)) : tryRight' xs (y1+1,y2)
          tryUpLeft :: (String,Posn) -> ([Posn],WordSearchGrid) -> Bool
          tryUpLeft (xi,pos) (ys,y) = and $ map (\(x,z) -> canCharacter x z ys y) $ tryUpLeft' xi pos
          tryUpLeft' :: String -> Posn -> [(Char,Posn)]
          tryUpLeft' [] _ = []
          tryUpLeft' (x:xs) (y1,y2) = (x,(y1,y2)) : tryUpLeft' xs (y1-1,y2-1)
          tryUpRight :: (String,Posn) -> ([Posn],WordSearchGrid) -> Bool
          tryUpRight (xi,pos) (ys,y) = and $ map (\(x,z) -> canCharacter x z ys y) $ tryUpRight' xi pos
          tryUpRight' :: String -> Posn -> [(Char,Posn)]
          tryUpRight' [] _ = []
          tryUpRight' (x:xs) (y1,y2) = (x,(y1,y2)) : tryUpRight' xs (y1+1,y2-1)
          tryDownLeft :: (String,Posn) -> ([Posn],WordSearchGrid) -> Bool
          tryDownLeft (xi,pos) (ys,y) = and $ map (\(x,z) -> canCharacter x z ys y) $ tryDownLeft' xi pos
          tryDownLeft' :: String -> Posn -> [(Char,Posn)]
          tryDownLeft' [] _ = []
          tryDownLeft' (x:xs) (y1,y2) = (x,(y1,y2)) : tryDownLeft' xs (y1-1,y2+1)
          tryDownRight :: (String,Posn) -> ([Posn],WordSearchGrid) -> Bool
          tryDownRight (xi,pos) (ys,y) = and $ map (\(x,z) -> canCharacter x z ys y) $ tryDownRight' xi pos
          tryDownRight' :: String -> Posn -> [(Char,Posn)]
          tryDownRight' [] _ = []
          tryDownRight' (x:xs) (y1,y2) = (x,(y1,y2)) : tryDownRight' xs (y1+1,y2+1)
--fetchPosition is a helperfunction which will find what character is at a specific position in the grid
          fetchPosition :: Posn -> WordSearchGrid -> Char
          fetchPosition (x1,x2) ys = ys!!x2!!x1
--can character checks if it is possible for a character to be placed somewhere, eg if it is within the range of the grid
--canCharacter also checks if the character if going to replace a character of another word, it will allow if it is the same as the one before it
          canCharacter :: Char -> Posn -> [Posn] -> WordSearchGrid -> Bool
          canCharacter x y@(y1,y2) zs grid | or [y1<0,y2<0,y1>=length grid,y2>=length grid] = False
                                           | Challenges.find y zs = if (x == fetchPosition y grid) then True
                                                         else False
                                           | otherwise = True
          replaceGrid :: Char -> Posn -> WordSearchGrid -> WordSearchGrid --helper function to replace a character a a position in the grid, searches through rows
          replaceGrid _ _ [] = []
          replaceGrid x (y1,0) (z:zs) = replaceGrid' x y1 z : zs
          replaceGrid x (y1,y2) (z:zs) = z : replaceGrid x (y1,y2-1) zs
          replaceGrid' :: Char -> Int -> String -> String --utility function used by replaceGrid, searches through columns
          replaceGrid' _ _ [] = []
          replaceGrid' x 0 (z:zs) = x : zs
          replaceGrid' x y (z:zs) =z : replaceGrid' x (y-1) zs
          --inserts a word where each character is paired with its destination position, also updates the position list
          insertWord :: [Posn] -> WordSearchGrid -> [(Char,Posn)] -> ([Posn],WordSearchGrid)
          insertWord ps grid [] = (ps,grid)
          insertWord ps grid ((x,p):xs) = insertWord (ps ++ [p]) (replaceGrid x p grid) xs


--- Convenience functions supplied for testing purposes
createAndSolve :: [ String ] -> Double -> IO [ (String, Maybe Placement) ]
createAndSolve words maxDensity =   do g <- createWordSearch words maxDensity
                                       let soln = solveWordSearch words g
                                       printGrid g
                                       return soln

printGrid :: WordSearchGrid -> IO ()
printGrid [] = return ()
printGrid (w:ws) = do putStrLn w
                      printGrid ws



-- Challenge 3 --

prettyPrint :: LamMacroExpr -> String
prettyPrint  (LamDef xs expression) = printMacros xs ++ (tail $ checkExpr expression)
    where macroList = xs
    --printMacros is used to recursivly print all of the macros one after another
          printMacros :: [(String,LamExpr)] -> String
          printMacros [] = []
          printMacros ((xi,x):xs) | (length xi > 0) && (and $ map isUpper xi) = "def "++xi++" = "++ (tail $ printExpression x) ++" in " ++ printMacros xs
                                  | otherwise = error "invalid name given to macro"
          searchMacros :: LamExpr -> [(String,LamExpr)] -> String
          searchMacros _ [] = ""
          searchMacros x ((yi,y):ys) | y == x = " "++yi
                                     | otherwise = searchMacros x ys
          --printExpression prints recursively using checkExpr to on each sub expression to check for macros
          printExpression :: LamExpr -> String
          printExpression (LamMacro x) | (and $ map isUpper x) = " "++x
                                       | otherwise = error "invalid name given to macro"
          printExpression (LamVar x) | x>0 = " x"++show x
                                     | otherwise = error "variable name not natural number"
          printExpression (LamAbs x expr) | x>0 = " \\x"++show x++" ->"++checkExpr expr
                                          | otherwise = error "variable name not natural number"
          printExpression (LamApp expr1 expr2) = checkExpr' expr1 ++checkExpr'' expr2
          --checkExpr is used for checking if the expression is a macro, if not, it goes back to printexpression
          checkExpr :: LamExpr -> String
          checkExpr x | (length $ searchMacros x macroList) == 0 = printExpression x
                      | otherwise = searchMacros x macroList
          --if the lamAbs is the first expression in a LamApp, then it should be bracketed, else it would form a different expression, unless it is a macro
          checkExpr' :: LamExpr -> String
          checkExpr' x@(LamAbs _ _) | (length $ searchMacros x macroList) == 0 = " ("++(tail $ printExpression x)++")"
                                    | otherwise = searchMacros x macroList
          checkExpr' x = checkExpr x
          --if the second expression of a LamApp is another LamApp, it must be bracketed, unless it is a macro
          checkExpr'' :: LamExpr -> String
          checkExpr'' x@(LamApp _ _) | (length $ searchMacros x macroList) == 0 = " ("++(tail $ printExpression x)++")"
                                     | otherwise = searchMacros x macroList
          checkExpr'' x = checkExpr x

-- examples in the instructions
ex3'1 = LamDef [] (LamApp (LamAbs 1 (LamVar 1)) (LamAbs 1 (LamVar 1)))
ex3'2 = LamDef [] (LamAbs 1 (LamApp (LamVar 1) (LamAbs 1 (LamVar 1))))
ex3'3 = LamDef [ ("F", LamAbs 1 (LamVar 1) ) ] (LamAbs 2 (LamApp (LamVar 2) (LamMacro "F")))
ex3'4 = LamDef [ ("F", LamAbs 1 (LamVar 1) ) ] (LamAbs 2 (LamApp (LamAbs 1 (LamVar 1)) (LamVar 2)))


-- -- Challenge 4 --

parseLamMacro :: String -> Maybe LamMacroExpr
parseLamMacro xs = parsing $ removeSpace xs
          --parsing will parse the string then make sure the parse didnt fail, then test it
    where parsing :: String -> Maybe LamMacroExpr
          parsing x | length a == 0 = Nothing
                    | length (snd $ a!!0) /= 0 = Nothing
                    | test (fst $ a!!0) = Just (fst $ a!!0)
                    | otherwise = Nothing
                        where a = parse macros x
          --test is a general function which uses two other functions to conduct tests
          test :: LamMacroExpr -> Bool
          test (LamDef xs _) | dupe xs [] = False
                             | or $ map free xs = False
                             | otherwise = True
          --dupe returns true if any of the macro names are the same
          dupe :: [(String,LamExpr)] -> [String] -> Bool
          dupe [] _ = False
          dupe ((x,_):xs) ys | dupe' x ys = True
                             | otherwise = dupe xs (x:ys)
          --dupe' returns true if the element inputted apears at least once in the list inputted
          dupe' :: Eq a => a -> [a] -> Bool
          dupe' _ [] = False
          dupe' x (y:ys) | x == y = True
                         | otherwise = dupe' x ys
          --free is a buffer function which gets rid of the macro name
          free :: (String,LamExpr) -> Bool
          free (_,y) = not $ free' y []
          --free' tests if there are any free variables in the macro inputted
          free' :: LamExpr -> [Int] -> Bool
          free' (LamMacro _) _ = True
          free' (LamApp x y) z = and [free' x z, free' y z]
          free' (LamAbs x y) z = free' y (x:z)
          free' (LamVar x) z = dupe' x z
          --removeSpace is used to get rid of any spaces in the string before parsing, although leaves spaces in between macro names so they can be differentiated
          removeSpace :: String -> String
          removeSpace [] = []
          removeSpace (x:x1:x2:xs) | and [isUpper x, x1==' ', isUpper x2] = x:x1: removeSpace (x2:xs)
          removeSpace (x:xs) | x == ' ' = removeSpace xs
                             | otherwise = x : removeSpace xs
          --macros is parsed at the begining and creates a list of 0 or more macros before moving to the expressions
          macros :: Parser LamMacroExpr
          macros = do a <- many macro
                      b <- expr
                      return (LamDef a b)
          --macro parses a macro and their expression, returns its name and the parsed expression
          macro :: Parser (String,LamExpr)
          macro = do char 'd'
                     char 'e'
                     char 'f'
                     a <- macroName
                     char '='
                     b <- expr
                     char 'i'
                     char 'n'
                     return (a,b)
          --in order to implement associativity, i used multiple parses after each other
          --as abstractions have the lowest precedence, it is first in the parse tree
          expr :: Parser LamExpr
          expr = do char '\\'
                    a <- var
                    char '-'
                    char '>'
                    b <- expr
                    return (LamAbs a b)
                 <|> applicat
          --applications are second in the parsing tree
          applicat :: Parser LamExpr
          applicat = do a <- value
                        b <- applicat
                        return (LamApp a b)
                     <|> value
          --lastly it checks for brackets and then values
          value :: Parser LamExpr
          value = do char '('
                     a <- expr
                     char ')'
                     return a
                  <|> do a <- var
                         return (LamVar a)
                  <|> macroDiff
          --these are basic concrete syntax which help to parse the rest of the expression
          var :: Parser Int
          var = do char 'x'
                   a <- nat
                   return a
          macroName :: Parser String
          macroName = some upper
          --macroDiff is used to differentiate between situation where if M and MM are macro names "MM" and "M M" or "M M M"
          macroDiff :: Parser LamExpr
          macroDiff = do a <- macroName
                         char ' '
                         b <- macroName
                         return (LamApp (LamMacro a) (LamMacro b))
                      <|> do space
                             a <- macroName
                             return (LamMacro a)

-- Challenge 5

cpsTransform :: LamMacroExpr -> LamMacroExpr
cpsTransform x = macros x (maximum $ getVar x)
    where macros :: LamMacroExpr -> Int -> LamMacroExpr --Macros is used to transform each of the macros macros
          macros (LamDef xs exp) y = (LamDef (map (macro y) xs) (expr exp y))
          macro :: Int -> (String, LamExpr) -> (String, LamExpr)
          macro z (x,y) = (x,expr y z)
          --expr is doing the actual translation, it recursivly calls itself until all internal expressions are translated
          --variable z is used to hold the current largest value used as a name (for variables in scope) so we can use a larger number to prevent overlap
          expr :: LamExpr -> Int -> LamExpr
          expr (LamVar x) z | x>0 = (LamAbs (z+1) (LamApp (LamVar (z+1)) (LamVar x)))
                            | otherwise = error "variable name not natural number"
          expr (LamAbs x y) z | x>0 = (LamAbs (z+1) (LamApp (LamVar (z+1)) (LamAbs x (expr y (z+1)))))
                              | otherwise = error "variable name not natural number"
          expr (LamApp x y) z = (LamAbs (z+1) (LamApp (expr x (z+3)) (LamAbs (z+2) (LamApp (expr y (z+3)) (LamAbs (z+3) (LamApp (LamApp (LamVar (z+2)) (LamVar (z+3))) (LamVar (z+1))))))))
          expr (LamMacro x) _ | and $ map isUpper x = (LamMacro x)
                              | otherwise = error "invalid name given to macro"
          --getVar and its prime functions are used to get all of the values of the variables in order to prevent any overlap with new variables during translation
          getVar :: LamMacroExpr -> [Int]
          getVar (LamDef xs exp) = getVar' xs ++ getVar'' exp
          getVar' :: [(String,LamExpr)] -> [Int]
          getVar' [] = []
          getVar' ((x,exp):xs) | and $ map isUpper x = getVar'' exp ++ getVar' xs
                               | otherwise = error "invalid name given to macro" --i incoporated syntax checking as well
          getVar'' :: LamExpr -> [Int]
          getVar'' (LamVar x) = [x]
          getVar'' (LamAbs x y) = [x] ++ getVar'' y
          getVar'' (LamApp x y) = getVar'' x ++ getVar'' y
          getVar'' (LamMacro _) = []
          --maximum is used to get the name of the largest variable on start, this is used as a minimum for names of variables inputted into the expression
          maximum :: [Int] -> Int
          maximum [x] = x
          maximum (x:xi:xs) | xi>x = maximum (xi:xs)
                            | otherwise = maximum (x:xs)

-- Examples in the instructions
exId =  (LamAbs 1 (LamVar 1))
ex5'1 = (LamApp (LamVar 1) (LamVar 2))
ex5'2 = (LamDef [ ("F", exId) ] (LamVar 2) )
ex5'3 = (LamDef [ ("F", exId) ] (LamMacro "F") )
ex5'4 = (LamDef [ ("F", exId) ] (LamApp (LamMacro "F") (LamMacro "F")))


-- Challenge 6

innerRedn1 :: LamMacroExpr -> Maybe LamMacroExpr
innerRedn1 a@(LamDef xs expr) = encapsulate $ emptyMacros (findStep expr xs) a
          --findStep finds next regex in the expression inputted and enacts it in innermost reduction
    where findStep :: LamExpr -> [(String,LamExpr)] -> Maybe (LamExpr,[(String,LamExpr)])--the function carries around the list of macros so they can be removed as they are used
          --if it finds an abstraction, it will first check for any regexes inside of the expressions, if not, it will enact the beta reduction
          findStep (LamApp (LamAbs x expr) (expr2)) zs | isJust a = Just ((LamApp (LamAbs x (fst $ fromMaybe a)) expr2),snd $ fromMaybe a)
                                                       | hasLambda expr2 && isJust b = Just ((LamApp (LamAbs x expr) (fst $ fromMaybe b)),snd $ fromMaybe b)
                                                       | otherwise = Just ((beta x expr expr2),zs)
                                                           where a = findStep expr zs
                                                                 b = findStep expr2 zs
          findStep (LamVar x) zs = Nothing
          findStep (LamMacro x) zs = Just (findMacro x zs []) --if it finds a macro, it will enact the macro
          findStep (LamAbs x (expr)) zs | isJust a = Just (LamAbs x (fst $ fromMaybe a), snd $ fromMaybe a)
                                        | otherwise = Nothing
                                            where a = findStep expr zs
          --if it finds any applications within applications, it will search through them first before the rest of the application
          findStep (LamApp x@(LamApp _ _) expr2) zs | isJust a = Just ((LamApp (fst $ fromMaybe a) expr2),snd $ fromMaybe a)
                                                        where a = findStep x zs
          findStep (LamApp expr x@(LamApp _ _)) zs | isJust a = Just ((LamApp expr (fst $ fromMaybe a)),snd $ fromMaybe a)
                                                       where a = findStep x zs
          findStep (LamApp (expr) (expr2)) zs | isJust a = Just (LamApp (fst $ fromMaybe a) expr2, snd $ fromMaybe a)
                                              | isJust b = Just (LamApp expr (fst $ fromMaybe b), snd $ fromMaybe b)
                                              | otherwise = Nothing
                                                  where a = findStep expr zs
                                                        b = findStep expr2 zs
          --hasLambda is finds whether there is an abstraction within the expression inputted
          hasLambda :: LamExpr -> Bool
          hasLambda (LamVar _) = False
          hasLambda (LamAbs _ _) = True
          hasLambda (LamMacro _) = False
          hasLambda (LamApp x y) = or [hasLambda x, hasLambda y]

outerRedn1 :: LamMacroExpr -> Maybe LamMacroExpr
outerRedn1 a@(LamDef xs expr) = encapsulate $ emptyMacros (findStep expr xs) a
          --findStep finds the next regex in the expression inputted and enacts it in outermost reduction
    where findStep :: LamExpr -> [(String,LamExpr)] -> Maybe (LamExpr,[(String,LamExpr)]) --the function carries around the list of macros so they can be removed as they are used
          findStep (LamApp (LamAbs x expr) (expr2)) zs = Just ((beta x expr expr2), zs) --if it finds a lambda expression, it will enact a beta expression
          findStep (LamVar x) zs = Nothing
          findStep (LamMacro x) zs = Just (findMacro x zs []) --if it finds a macro, it will sub in the macro
          findStep (LamAbs x (expr)) zs | isJust a = Just (LamAbs x (fst $ fromMaybe a), snd $ fromMaybe a)
                                        | otherwise = Nothing
                                            where a = findStep expr zs
          findStep (LamApp (expr) (expr2)) zs | isJust a = Just (LamApp (fst $ fromMaybe a) expr2, snd $ fromMaybe a) --in an application, it will attempt the right expression first
                                              | isJust b = Just (LamApp expr (fst $ fromMaybe b), snd $ fromMaybe b)
                                              | otherwise = Nothing
                                                  where a = findStep expr zs
                                                        b = findStep expr2 zs

compareInnerOuter :: LamMacroExpr -> Int -> (Maybe Int,Maybe Int,Maybe Int,Maybe Int)
compareInnerOuter expr bound = (apply expr 0 innerRedn1,apply expr 0 outerRedn1,innerCPS $ cpsTransform expr,outerCPS $ cpsTransform expr)
    where b = bound
          --apply recursively calls the given function on the macro expression until there are no regexes left at which point it returns how many steps it took
          --it will return nothing if it the bound for number of steps is reached
          apply :: LamMacroExpr -> Int -> (LamMacroExpr -> Maybe LamMacroExpr) -> Maybe Int
          apply _ y z | y>b = Nothing
          apply x y z | isJust a = apply (fromMaybe a) (y+1) z
                      | otherwise = Just y
                          where a = z x
          --innerCPS and outerCPS cps transform the expression and add an application to the end
          --i gave the new variables name 0, as this is techincally breaking the rules (as its not a natural number), but its the easiest way to ensure that the variable wont have overlap
          innerCPS :: LamMacroExpr -> Maybe Int
          innerCPS (LamDef x y) = apply (LamDef x (LamApp y (LamAbs 0 (LamVar 0)))) 0 innerRedn1
          outerCPS :: LamMacroExpr -> Maybe Int
          outerCPS (LamDef x y) = apply (LamDef x (LamApp y (LamAbs 0 (LamVar 0)))) 0 outerRedn1
          extract :: LamMacroExpr -> LamExpr
          extract (LamDef _ y) = y

-- Examples in the instructions

-- (\x1 -> x1 x2)
ex6'1 = LamDef [] (LamAbs 1 (LamApp (LamVar 1) (LamVar 2)))

--  def F = \x1 -> x1 in F  
ex6'2 = LamDef [ ("F",exId) ] (LamMacro "F")

--  (\x1 -> x1) (\x2 -> x2)   
ex6'3 = LamDef [] ( LamApp exId (LamAbs 2 (LamVar 2)))

--  (\x1 -> x1 x1)(\x1 -> x1 x1)  
wExp = (LamAbs 1 (LamApp (LamVar 1) (LamVar 1)))
ex6'4 = LamDef [] (LamApp wExp wExp)

--  def ID = \x1 -> x1 in def FST = (\x1 -> λx2 -> x1) in FST x3 (ID x4) 
ex6'5 = LamDef [ ("ID",exId) , ("FST",LamAbs 1 (LamAbs 2 (LamVar 1))) ] ( LamApp (LamApp (LamMacro "FST") (LamVar 3)) (LamApp (LamMacro "ID") (LamVar 4)))

--  def FST = (\x1 -> λx2 -> x1) in FST x3 ((\x1 ->x1) x4))   
ex6'6 = LamDef [ ("FST", LamAbs 1 (LamAbs 2 (LamVar 1)) ) ]  ( LamApp (LamApp (LamMacro "FST") (LamVar 3)) (LamApp (exId) (LamVar 4)))

-- def ID = \x1 -> x1 in def SND = (\x1 -> λx2 -> x2) in SND ((\x1 -> x1 x1) (\x1 -> x1 x1)) ID
ex6'7 = LamDef [ ("ID",exId) , ("SND",LamAbs 1 (LamAbs 2 (LamVar 2))) ]  (LamApp (LamApp (LamMacro "SND") (LamApp wExp wExp) ) (LamMacro "ID") )


--helper functions
--isJust is used in ch 6, and is used to check if a maybe statement is Just or Nothing
isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust (Nothing) = False

--fromMaybe is used in ch 6 and is used to convert a Just to without its shell
fromMaybe :: Maybe a -> a
fromMaybe (Just a) = a
fromMaybe Nothing = error "not Just"

--beta is used in ch 6 and enacts a beta reduction on the given input
beta :: Int -> LamExpr -> LamExpr -> LamExpr
beta x (LamVar y) expr2 | x==y = expr2
                        | otherwise = (LamVar y)
beta x (LamAbs y expr) expr2 | x==y = (LamAbs x expr)
                             | otherwise = (LamAbs y (beta x expr expr2))
beta _ (LamMacro y) _ = (LamMacro y)
beta x (LamApp (expr) (expr2)) expr3 = (LamApp (beta x expr expr3) (beta x expr2 expr3))

--helper function used in order to check if an element is within a list
find :: Eq n => n -> [n] -> Bool
find _ [] = False
find n (x:xs) | x == n = True
              | otherwise = Challenges.find n xs

--findMacro is used in ch6 to find and remove a macro from a macroList
findMacro :: String -> [(String,LamExpr)] -> [(String,LamExpr)] -> (LamExpr,[(String,LamExpr)])
findMacro x [] zs = ((LamMacro x),zs)
findMacro x (a@(yi,y):ys) zs | x == yi = (y,zs++ys)
                             | otherwise = findMacro x ys ([a]++zs)

--if there are no regexes left in ch6, it will call this function which will remove the macros remaining one by one
emptyMacros :: Maybe (LamExpr,[(String,LamExpr)]) -> LamMacroExpr -> Maybe (LamExpr,[(String,LamExpr)])
emptyMacros (Just x) _ = Just x
emptyMacros Nothing (LamDef [] _) = Nothing
emptyMacros Nothing (LamDef (x:xs) y) = Just (y,xs)

--encapsulate is just used to take the mess from the rest of the functions in ch6 and put it into the form required
encapsulate :: Maybe (LamExpr,[(String,LamExpr)]) -> Maybe LamMacroExpr
encapsulate (Just (x,y)) = Just (LamDef y x)
encapsulate Nothing = Nothing