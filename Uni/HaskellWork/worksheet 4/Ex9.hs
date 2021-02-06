data RInt = Zero | Succ RInt | Pred RInt deriving Show

normalise :: RInt -> RInt
normalise x = start x Zero
    where start Zero y = y
          start (Succ x) (Pred y) = start x y
          start (Pred x) (Succ y) = start x y
          start (Succ x) y = start x (Succ y)
          start (Pred x) y = start x (Pred y)

even :: RInt -> Bool
even x = start (normalise x)
    where start Zero = True
          start (Succ Zero) = False
          start (Pred Zero) = False
          start (Pred (Pred x)) = start x
          start (Succ (Succ x)) = start x

odd :: RInt -> Bool
odd x = start (normalise x)
    where start Zero = False
          start (Succ Zero) = True
          start (Pred Zero) = True
          start (Pred (Pred x)) = start x
          start (Succ (Succ x)) = start x

add :: RInt -> RInt -> RInt
add x y = start (normalise x) (normalise y)
    where start x Zero = x
          start x (Succ y) = start (Succ x) y
          start x (Pred y) = start (Pred x) y 

mult :: RInt -> RInt -> RInt
mult x Zero = Zero
mult x y = multStep (normalise x) (normalise y)
    where z = x
          multStep x (Succ Zero) = x
          multStep x (Succ y) = add x z