altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap _ _ [] = []
altMap x y zs = odd x y zs
    where odd x y [] = []
          odd x y (z:zs) = x z : even x y zs
          even x y [] = []
          even x y (z:zs) = y z : odd x y zs