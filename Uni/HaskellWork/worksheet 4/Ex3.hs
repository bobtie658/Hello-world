curry :: ((a,b) -> c) -> (a -> b -> c)
curry x = \z y -> x (z,y)

uncurry :: (a -> b -> c) -> ((a,b) -> c)
uncurry x = \(z,y) -> x z y