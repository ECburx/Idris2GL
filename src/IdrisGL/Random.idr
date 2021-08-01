{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Random

import Data.Fin

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",random"

--

%foreign frgn "randomInt"
prim_randomInt : Int -> Int -> Int

||| An unsafe, predictable and limited random integer generator, in range [lower, upper].
||| Switch <lower> and <upper> if <upper> is LOWER than <lower>.
|||
||| This function is only for users who want to easily render random picture elements.
||| Please don't use it for precise calculations.
||| No random built-in functions been found in idris2 version 0.4.
|||
||| @ lower Lower bound.
||| @ upper Upper bound.
export
randomInt : (lower : Int) -> (upper : Int) -> Int
randomInt lower upper = prim_randomInt lower upper

||| An unsafe, predictable and limited random natrual number generator, in range [lower, upper].
||| Switch <lower> and <upper> if <upper> is LOWER than <lower>.
|||
||| This function is only for users who want to easily render random picture elements.
||| Please don't use it for precise calculations.
||| No random built-in functions been found in idris2 version 0.4.
|||
||| @ lower Lower bound.
||| @ upper Upper bound.
export
randomNat : (lower : Nat) -> (upper : Nat) -> Nat
randomNat lower upper = integerToNat . cast $ prim_randomInt (cast lower) (cast upper)

||| An unsafe, predictable and limited random (Fin upper) generator, in range [lower, upper].
||| Switch <lower> and <upper> if <upper> is LOWER than <lower>.
|||
||| This function is only for users who want to easily render random picture elements.
||| Please don't use it for precise calculations.
||| No random built-in functions been found in idris2 version 0.4.
|||
||| @ lower Lower bound.
||| @ upper Upper bound.
export
randomFin : (lower : Nat) -> (upper : Nat) -> Maybe $ Fin upper
randomFin lower upper = natToFin (randomNat lower upper) upper

export
randomPick : List a -> Maybe a
randomPick Nil = Nothing
randomPick l   =
    let i : Nat := randomNat 0 (minus (length l) 1)
    in  randomPick' i l
    where randomPick' : Nat -> List a -> Maybe a
          randomPick' _ Nil     = Nothing
          randomPick' 0 (x::xs) = Just x
          randomPick' i (x::xs) = randomPick' (minus i 1) xs