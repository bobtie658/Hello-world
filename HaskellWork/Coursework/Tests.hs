module Tests (
    wordSearchSolveTest,
    wordSearchGenerationTest,
    wordSearchGenerationTest2,
    printTest,
    printThenRead,
    readTest,
    cpsTransformTest,
    solveEvaluationTest
    )where


import Challenges

assert :: Bool -> String -> String -> IO()
assert test passInfo failInfo = if test then putStrLn passInfo else putStrLn failInfo

main :: IO()
main = do
    putStrLn "start testing"
    putStrLn "start ch1 testing"
    assert (wordSearchSolveTest ["fruits","apple","orange","mango","apricot","pear","melon","cherry","kiwi","lime","plum","lemon","fig"] ["akolimec","biregepa","fwamrlep","rinpaoar","ufglpnri","ineuelgc","tlemoneo","scherryt"] [("fruits",Just ((0,2),Down)),("apple",Just ((2,2),DownForward)),("orange",Just ((2,0),Down)),("mango",Just ((3,2),DownForward)),("apricot",Just ((7,1),Down)),("pear",Just ((6,1),Down)),("melon",Just ((5,0),Down)),("cherry",Just ((1,7),Forward)),("kiwi",Just ((1,0),Down)),("lime",Just ((3,0),Forward)),("plum",Just ((3,3),Down)),("lemon",Just ((1,6),Forward)),("fig",Just ((0,2),DownForward))]) "passed test 1" "failed on general grid"
    assert (wordSearchSolveTest [] ["aaa","aaa","aaa"] []) "passed for empty words" "failed to return empty set for no words"
    assert (wordSearchSolveTest ["aa"] [] [("aa",Nothing)]) "passed for empty grid" "failed on empty grid input"
    assert (wordSearchSolveTest ["a"] [[]] [("a",Nothing)]) "passed for empty grid in empty grid" "failed on empty grid in grid"
    assert (wordSearchSolveTest [""] ["a"] [("",Nothing)]) "passed for empty string search" "failed for empty string search"
    assert (wordSearchSolveTest ["one","","two"] ["tet","nnw","woo"] [("one",Just ((1,2),Up)),("",Nothing),("two",Just ((2,0),Down))]) "passed for empty string search" "failed for empty string search"
    putStrLn "end ch1 testing"
    putStrLn "start ch2 testing"
    wordSearchGenerationTest ["one","two"] 0.5
    wordSearchGenerationTest ["hello"] 0.1
    wordSearchGenerationTest2 [""] []
    wordSearchGenerationTest2 [] []
    putStrLn "end ch2 testing"
    putStrLn "start ch3 testing"
    assert (printTest (LamDef [] (LamApp (LamApp (LamVar 1) (LamVar 2)) (LamVar 3))) "x1 x2 x3") "passed on basic print" "failed on basic print"
    assert (printTest (LamDef [] (LamAbs 1 (LamApp (LamVar 1) (LamVar 1)))) "\\x1 -> x1 x1") "passed on lambda print" "failed on lambda print"
    assert (printTest (LamDef [("A",(LamAbs 1 (LamVar 2))),("T",(LamVar 2)),("H",(LamVar 2))] (LamApp (LamAbs 1 (LamVar 2)) (LamVar 2))) "def A = \\x1 -> T in def T = x2 in def H = x2 in A T") "passed on lambda expressions, macros and auto macro sub" "failed on lambda expressions, macros and auto macro sub"
    putStrLn "end ch3 testing"
    putStrLn "start ch4 testing"
    assert (readTest "\\x1 -> x1 x1" (Just (LamDef [] (LamAbs 1 (LamApp (LamVar 1) (LamVar 1)))))) "passed on reading lambda expression" "failed on reading lambda expression"
    assert (readTest "def A = \\x1 -> T in def T = \\x2 -> x2 in def H = \\x2 -> x2 in A T" (Just (LamDef [("A",LamAbs 1 (LamMacro "T")),("T",LamAbs 2 (LamVar 2)),("H",LamAbs 2 (LamVar 2))] (LamApp (LamMacro "A") (LamMacro "T"))))) "passed on macro read" "failed on macro read"
    assert (readTest "def MM = \\x1 -> x1 in MM" (Just (LamDef [("MM",LamAbs 1 (LamVar 1))] (LamMacro "MM")))) "passed two letter macro test" "failed two letter macro test"
    assert (readTest "def M = \\x1 -> x1 in M M" (Just (LamDef [("M",LamAbs 1 (LamVar 1))] (LamApp (LamMacro "M") (LamMacro "M"))))) "passed double macro test" "failed double macro test"
    assert (readTest "def M = \\x1 -> x1 in M M M" (Just (LamDef [("M",LamAbs 1 (LamVar 1))] (LamApp (LamApp (LamMacro "M") (LamMacro "M")) (LamMacro "M"))))) "passed tripple macro test" "failed tripple macro test"
    assert (readTest "DEF M = \\x1 -> x1 in M" Nothing) "passed incorrect grammar test" "failed incorrect grammar test"
    assert (readTest "def M = x1 in M" Nothing) "passed macro closure test" "failed macro closure test"
    assert (readTest "def M = \\x1 -> x1 in def M = \\x2 -> x2 in M" Nothing) "passed duplicate macro test" "failed duplicate macro test"
    assert (readTest "\\x1 -> x1 x-1" Nothing) "passed incorrect variable name test" "failed incorrect variable name test"
    putStrLn "end ch4 testing"
    putStrLn "start ch5 testing"
    assert (cpsTransformTest (LamDef [ ("F", (LamAbs 1 (LamVar 1))) ] (LamVar 2)) (LamDef [("F",LamAbs 3 (LamApp (LamVar 3) (LamAbs 1 (LamAbs 4 (LamApp (LamVar 4) (LamVar 1))))))] (LamAbs 3 (LamApp (LamVar 3) (LamVar 2))))) "passed basic tranform test" "failed basic transform test"
    assert (cpsTransformTest (LamDef [ ("F", (LamAbs 1 (LamVar 1))) ] (LamApp (LamMacro "F") (LamMacro "F"))) (LamDef [("F",LamAbs 2 (LamApp (LamVar 2) (LamAbs 1 (LamAbs 3 (LamApp (LamVar 3) (LamVar 1))))))] (LamAbs 2 (LamApp (LamMacro "F") (LamAbs 3 (LamApp (LamMacro "F") (LamAbs 4 (LamApp (LamApp (LamVar 3) (LamVar 4)) (LamVar 2))))))))) "passed macro and application test" "failed macro and application test"
    putStrLn "end ch5 testing"
    putStrLn "start ch6 testing"
    assert (solveEvaluationTest (LamDef [] (LamApp (LamAbs 1 (LamApp (LamVar 1) (LamVar 1))) (LamAbs 1 (LamApp (LamVar 1) (LamVar 1))))) 1000 (Nothing,Nothing,Nothing,Nothing)) "passed bound test" "failed bound test"
    assert (solveEvaluationTest (LamDef [("ID",(LamAbs 1 (LamVar 1))),("FST",LamAbs 1 (LamAbs 2 (LamVar 1)))] (LamApp (LamApp (LamMacro "FST") (LamVar 3)) (LamApp (LamMacro "ID") (LamVar 4)))) 30 (Just 4,Just 4,Just 22,Just 22)) "passed general macro test" "failed general macro test"
    assert (solveEvaluationTest (LamDef [("FST",LamAbs 1 (LamAbs 2 (LamVar 1)))] (LamApp (LamApp (LamMacro "FST") (LamVar 3)) (LamApp (LamAbs 1 (LamVar 1)) (LamVar 4)))) 30 (Just 4,Just 3,Just 21,Just 21)) "passed 2nd general macro test" "failed 2nd general macro test"
    putStrLn "end ch6 testing"
    putStrLn "end testing"

wordSearchSolveTest :: [String] -> WordSearchGrid -> [(String,Maybe Placement)] -> Bool
wordSearchSolveTest find grid answer | solveWordSearch find grid == answer = True
                                     | otherwise = False

wordSearchGenerationTest :: [String] -> Double -> IO()
wordSearchGenerationTest xs y = do a <- createAndSolve xs y
                                   if (and $ map (\x -> ((snd x) /= Nothing)) a) then putStrLn "created grid works"
                                   else putStrLn "created grid fails"
                                       where createAndSolve words maxDensity = do g <- createWordSearch words maxDensity
                                                                                  let soln = solveWordSearch words g
                                                                                  return soln

wordSearchGenerationTest2 :: [String] -> [String] -> IO()
wordSearchGenerationTest2 x y = do a <- createWordSearch x 0.5
                                   if (a==y) then putStrLn "grid was created successfully" else putStrLn "grid created failed"

printTest :: LamMacroExpr -> String -> Bool
printTest expr answer | (prettyPrint expr) == answer = True
                      | otherwise = False

printThenRead :: LamMacroExpr -> Bool
printThenRead x | (Just x) == (parseLamMacro $ prettyPrint x) = True
                | otherwise = False

readTest :: String -> Maybe LamMacroExpr -> Bool
readTest x answer | answer == (parseLamMacro x) = True
                  | otherwise = False

cpsTransformTest :: LamMacroExpr -> LamMacroExpr -> Bool
cpsTransformTest input answer | (cpsTransform input) == answer = True
                              | otherwise = False

solveEvaluationTest :: LamMacroExpr -> Int -> (Maybe Int,Maybe Int,Maybe Int,Maybe Int) -> Bool
solveEvaluationTest input bound answer | (compareInnerOuter input bound) == answer = True
                                       | otherwise = False