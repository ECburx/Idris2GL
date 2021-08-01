{- Tian Z (ecburx@burx.vip) -}

module Tile

import IdrisGL

||| The width (pixel) of a square tile.
export
tileWidth   : Int
tileWidth   = 70

||| The spacing (pixel) between two tiles.
export
tileSpacing : Int
tileSpacing = 15

nat2pic : (nat : Nat) -> (x : Int) -> (y : Int) -> Picture
nat2pic nat x y = Bitmap ("png/" ++ show nat ++ ".bmp") (MkRect x y tileWidth tileWidth)

export
tileToPic : (i : Int) -> (j : Int) -> (tile : Nat) -> Picture
tileToPic i j tile = nat2pic tile (realPos i) (realPos j)
    where ||| 
          realPos : (p : Int) -> Int
          realPos p = p * (tileWidth + tileSpacing) + tileSpacing