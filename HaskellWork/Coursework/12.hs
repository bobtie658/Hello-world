import System.Random

type WordSearchGrid = [[Char]]
type Placement = (Posn,Orientation)
type Posn = (Int,Int)
data Orientation = Forward | Back | Up | Down | UpForward | UpBack | DownForward | DownBack deriving (Eq,Ord,Show,Read)

createWordSearch :: [String] -> Double -> IO WordSearchGrid
createWordSearch [] _ = return []
createWordSearch xs y = makeGrid (getCharacters xs "") (floor $ sqrt $ (fromIntegral $ sum $ map length xs)/y) (-1)
    where makeGrid :: String -> Int -> Int -> IO WordSearchGrid
          makeGrid xs y (-1) = makeGrid xs y y
          makeGrid xs y z = if (y>0) then do a <- randomString xs z
                                             b <- makeGrid xs (y-1) z
                                             return $ a : b
                                     else return []
          randomString :: [b] -> Int -> IO [b]
          randomString xs y = if (y>0) then do a <- randomChar xs
                                               b <- randomString xs (y-1)
                                               return $ a : b
                                       else return []
          randomChar :: [b] -> IO b
          randomChar xs = do a <- randomRIO (0,(length xs)-1)
                             return (xs!!a)
          getCharacters :: [String] -> String -> String
          getCharacters [] ys = ys
          getCharacters (x:xs) ys = getCharacters xs $ checkSubstring ys x
          checkSubstring :: String -> String -> String
          checkSubstring ys [] = ys
          checkSubstring ys (x:xs) | find x ys = checkSubstring ys xs
                                   | otherwise = checkSubstring (ys ++ [x]) xs
          find :: Char -> String -> Bool
          find _ [] = False
          find n (x:xs) | x == n = True
                        | otherwise = find n xs

printGrid :: WordSearchGrid -> IO ()
printGrid [] = return ()
printGrid (w:ws) = do putStrLn w
                      printGrid ws
