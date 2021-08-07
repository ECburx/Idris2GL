{- Tian Z (ecburx@burx.vip) -}

module Illusion

{- Illusion.
   Tricks deriving from Lenstore.
  
   $ idris2 -p idrisGL
   Main> :l "Illusion.idr"
   Illusion> :exec main
-}

import IdrisGL
import IdrisGL.Color as Color

windowWidth : Int
windowWidth = 500

window : Display
window = InWindow "Illusion" (MkRect 50 50 windowWidth 305)

plus20s : (n : Int) -> Stream Int
plus20s n = n :: plus20s (36 + n)

blackTapes  : (time : Double) -> List Picture
blackTapes time with (cast time `mod` 6 < 3)
  blackTapes time | False = Nil
  blackTapes time | True  = blackTape <$> take 9 (plus20s 0)
  where blackTape : (y : Int) -> Picture
        blackTape y = Rectangle (MkRect 0 y windowWidth 18) Color.black True

whiteTapes  : (time : Double) -> List Picture
whiteTapes time with (cast time `mod` 6 < 3)
  whiteTapes time | False = Nil
  whiteTapes time | True  = whiteTape <$> take 8 (plus20s 0)
where whiteTape : (y : Int) -> Picture
      whiteTape y = Rectangle (MkRect (div windowWidth 2) (y+19) (div windowWidth 2) 16) Color.white True

leftPear    : (time : Double) -> Picture
leftPear  time = Rotate (time*40) (MkCoor 125 150) (Image "pear.png" (MkRect 50 0 150 300))

rightPear   : (time : Double) -> Picture
rightPear time = Rotate (time*40) (MkCoor 375 150) (Image "pear.png" (MkRect 300 0 150 300))

timeHandler : (t : Double) -> Picture
timeHandler t = Pictures $ leftPear t :: blackTapes t ++ [rightPear t] ++ whiteTapes t

main : IO ()
main = animate window Color.white 0.05 timeHandler