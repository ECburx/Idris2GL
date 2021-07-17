{- Tian Z (ecburx@burx.vip) -}

module Map

import IdrisGL
import Data.Vect

{- Blocks -}

export
blockWidth : Int
blockWidth = 24

position : (Int,Int) -> Rect
position (x,y) = MkRect (x*blockWidth) (y*blockWidth) blockWidth blockWidth

-- 1
grass : (Int,Int) -> Picture
grass pos = Bitmap "bmp/grass.bmp" (position pos)

-- 2
rock  : (Int,Int) -> Picture
rock  pos = Bitmap "bmp/rock.bmp"  (position pos)

-- 3
sand  : (Int,Int) -> Picture
sand  pos = Bitmap "bmp/sand.bmp"  (position pos)

-- 4
wall  : (Int,Int) -> Picture
wall  pos = Bitmap "bmp/wall.bmp"  (position pos)

-- 5
water : (Int,Int) -> Picture
water pos = Bitmap "bmp/water.bmp" (position pos)

-- 6
wood  : (Int,Int) -> Picture
wood  pos = Bitmap "bmp/wood.bmp"  (position pos)

-- Convert a block code to a Picture
blockCode2Picture : Nat -> (Int,Int) -> Picture
blockCode2Picture 1 (x,y) = grass (x,y)
blockCode2Picture 2 (x,y) = rock  (x,y)
blockCode2Picture 3 (x,y) = sand  (x,y)
blockCode2Picture 4 (x,y) = wall  (x,y)
blockCode2Picture 5 (x,y) = water (x,y)
blockCode2Picture 6 (x,y) = wood  (x,y)
blockCode2Picture _ _     = Blank

{- Map -}

export
mapWidth  : Int
mapWidth  = 10

export
mapHeight : Int
mapHeight = mapWidth

public export
data Map = MP (List (List Nat))

export
map2picture : Map -> List Picture
map2picture (MP Nil)     = Nil
map2picture (MP (d::ds)) = iter 0 (d::ds)
    where iter' : Int -> Int -> List Nat -> List Picture
          iter' _  _  Nil     = Nil
          iter' li ci (b::bs) = blockCode2Picture b (li,ci) :: iter' li (ci+1) bs

          iter  : Int -> List (List Nat) -> List Picture
          iter  _     Nil     = Nil
          iter  li    (l::ls) = iter' li 0 l ++ iter (li+1) ls

export
getBlockCode : Map -> (Int,Int) -> Nat
getBlockCode (MP (l::ls)) (i,j) = 
    getCode (getLine (l::ls) i) j
    where getLine : List (List Nat) -> Int -> List Nat
          getLine Nil       _  = Nil
          getLine (l'::ls') 0  = l'
          getLine (l'::ls') i' = getLine ls' (i'-1)

          getCode : List Nat -> Int -> Nat
          getCode Nil     _  = 0
          getCode (c::cs) 0  = c
          getCode (c::cs) j' = getCode cs (j'-1)
getBlockCode _ _ = 0

export
map1 : Map
map1 = 
    MP [[4,4,4,4,4,4,1,1,4,4]
       ,[6,6,6,6,2,1,1,1,1,4]
       ,[6,2,2,6,2,1,1,1,1,1]
       ,[6,2,2,6,2,1,1,1,1,1]
       ,[6,6,2,6,2,1,1,3,3,3]
       ,[1,1,2,1,1,1,3,3,3,5]
       ,[1,1,1,1,3,3,3,5,5,5]
       ,[3,3,3,3,5,5,5,5,5,5]
       ,[3,3,3,5,5,5,5,5,5,5]
       ,[5,5,5,5,5,5,5,5,5,5]]