type WordSearchGrid = [[Char]]
type Placement = (Posn,Orientation)
type Posn = (Int,Int)
data Orientation = Forward | Back | Up | Down | UpForward | UpBack | DownForward | DownBack deriving (Eq,Ord,Show,Read)

solveWordSearch :: [String] -> WordSearchGrid -> [(String,Maybe Placement)]
solveWordSearch x y = map (search y (0,0)) x
    where search :: WordSearchGrid -> Posn -> String -> (String,Maybe Placement)
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
          searchUp :: WordSearchGrid -> Posn -> String -> Bool
          searchUp _ _ [] = True
          searchUp y (x1,x2) (zi:zs) | x2<length zs = False
                                     | y!!x2!!x1 == zi = searchUp y (x1,x2-1) zs
                                     | otherwise = False
          searchDown _ _ [] = True
          searchDown y (x1,x2) (zi:zs) | length y -x2<=length zs = False
                                       | y!!x2!!x1 == zi = searchDown y (x1,x2+1) zs
                                       | otherwise = False
          searchRight _ _ [] = True
          searchRight y (x1,x2) (zi:zs) | length y -x1<=length zs = False
                                        | y!!x2!!x1 == zi = searchRight y (x1+1,x2) zs
                                        | otherwise = False
          searchLeft _ _ [] = True
          searchLeft y (x1,x2) (zi:zs) | x1<length zs = False
                                       | y!!x2!!x1 == zi = searchLeft y (x1-1,x2) zs
                                       | otherwise = False
          searchUpRight _ _ [] = True
          searchUpRight y (x1,x2) (zi:zs) | x2<length zs = False
                                          | length y -x1<=length zs = False
                                          | y!!x2!!x1 == zi = searchUpRight y (x1+1,x2-1) zs
                                          | otherwise = False
          searchUpLeft _ _ [] = True
          searchUpLeft y (x1,x2) (zi:zs) | x2<length zs = False
                                         | x1<length zs = False
                                         | y!!x2!!x1 == zi = searchUpLeft y (x1-1,x2-1) zs
                                         | otherwise = False
          searchDownRight _ _ [] = True
          searchDownRight y (x1,x2) (zi:zs) | length y -x2<=length zs = False
                                            | length y -x1<=length zs = False
                                            | y!!x2!!x1 == zi = searchDownRight y (x1+1,x2+1) zs
                                            | otherwise = False
          searchDownLeft _ _ [] = True
          searchDownLeft y (x1,x2) (zi:zs) | length y -x2<=length zs = False
                                           | x1<length zs = False
                                           | y!!x2!!x1 == zi = searchDownLeft y (x1-1,x2+1) zs
                                           | otherwise = False
          iterate :: Posn -> WordSearchGrid -> Posn
          iterate (x1,x2) y | x1+1==length y && x2+1==length y = (-1,-1)
                            | x1+1==length y = (0,x2+1)
                            | otherwise = (x1+1,x2)