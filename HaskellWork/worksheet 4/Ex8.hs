data Nat = Zero | Succ Nat deriving (Eq,Ord,Show,Read)

even :: Nat -> Bool
even Zero = True
even (Succ Zero) = False
even (Succ (Succ (x))) = Main.even x

odd :: Nat -> Bool
odd Zero = False
odd (Succ Zero) = True
odd (Succ (Succ (x))) = Main.odd x

add :: Nat -> Nat -> Nat
add x Zero = x
add x (Succ y) = add (Succ x) y

mult :: Nat -> Nat -> Nat
mult x Zero = Zero
mult x y = multStep x y
    where z = x
          multStep x (Succ Zero) = x
          multStep x (Succ y) = add x z