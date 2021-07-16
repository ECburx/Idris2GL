{- Tian Z (ecburx@burx.vip) -}

module Kmeans

import IdrisGL
import Data.Primitives.Views
import System
import Data.Bits

{- Kmeans.
   k-means clustering.

   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "Kmeans.idr"
   Kmeans> :exec main
-}

-- k == 3. Each color represents one set.
red   : Color
red   = MkColor 255 0 0 255
green : Color
green = MkColor 0 255 0 255
blue  : Color
blue  = MkColor 0 0 255 255

-- Black represents that a unit (coordinate) hasn't belong to any set.
white : Color
white = MkColor 255 255 255 255

-- The maximum possible data in dataset.
maxData : Int
maxData = 500

data UNIT = Ut Int Int Color

data DataSet = DS (List UNIT) (List UNIT)

-- initial dataset.
initDS : DataSet
initDS = 
   DS [Ut 358 276 white, Ut 181 143 white, Ut 87   34 white, Ut 295  25 white, Ut 388 139 white
      ,Ut 390 293 white, Ut 404 225 white, Ut 228  89 white, Ut 145  59 white, Ut 371  61 white
      ,Ut 368 207 white, Ut 259 283 white, Ut 320 158 white, Ut 202 126 white, Ut 323  96 white
      ,Ut 155 112 white, Ut 229 187 white, Ut 223 225 white, Ut 304 190 white, Ut 339  54 white
      ,Ut 334 118 white, Ut 143 144 white, Ut 226 262 white, Ut 375 273 white, Ut 273 129 white
      ,Ut  85 160 white, Ut 156 222 white, Ut 109 154 white, Ut 255 221 white, Ut 207 275 white]
      -- Center of each set.
      -- However, in the actual kmeans operation, 
      --   you should use randomly selected data as the initial set centers, insteading of presetting them.
      [Ut   6 300 red  , Ut 240   6 green, Ut 474 300 blue]

-- a function to display a dataset.
showDS : DataSet -> Picture
showDS (DS units ks)              = Pictures (frame :: k2p ks ++ u2p units)
   where radius : Int
         radius = 5

         u2p : List UNIT -> List Picture
         u2p Nil                  = Nil
         u2p (Ut x y color :: us) = Circle (MkCoor x y) color False radius :: u2p us

         k2p : List UNIT -> List Picture
         k2p Nil                  = Nil
         k2p (Ut x y color :: ks) = k2p ks ++
            [ThickLine (MkCoor (x-radius) (y-radius)) (MkCoor (x+radius) (y+radius)) color 3 
            ,ThickLine (MkCoor (x-radius) (y+radius)) (MkCoor (x+radius) (y-radius)) color 3]

         frame : Picture
         frame = Rectangle (MkRect 10 10 480 300) (MkColor 60 60 60 255) True

updateDS : Double -> DataSet -> DataSet
updateDS _ (DS units ks) =
   let udUnits = updateUnits units in DS udUnits (updateKs ks udUnits)
   where ipow2 : Int -> Int
         ipow2 a = a * a

         belong : UNIT -> List UNIT -> Int -> UNIT
         belong unit Nil _ = unit
         belong unit@(Ut ux uy _) (Ut kx ky color::ks') d2 = 
            let  d' = ipow2 (ux-kx) + ipow2 (uy-ky) in
            if   d' < d2
            then belong (Ut ux uy color) ks' d'
            else belong unit ks' d2

         updateUnits : List UNIT -> List UNIT
         updateUnits Nil     = Nil
         updateUnits (u::us) = belong u ks (ipow2 maxData) :: updateUnits us

         xySum : UNIT -> List UNIT -> (Int, Int, Int)
         xySum _ [] = (0,0,0)
         xySum k@(Ut _ _ uColor) (Ut x y kColor::us) =
            let  (xs, ys, num) = xySum k us in
            if   uColor == kColor
            then (xs+x, ys+y, num+1)
            else (  xs,   ys,   num)
         
         updateKs : List UNIT -> List UNIT -> List UNIT
         updateKs Nil _ = Nil
         updateKs (k@(Ut _ _ color)::ks) units =
            let (xs, ys, num) = xySum k units in
            if num == 0 
            then k :: updateKs ks units 
            else Ut (div xs num) (div ys num) color :: updateKs ks units

main : IO ()
main = 
   simulate
       (InWindow "Kmeans" (MkRect 50 50 500 320))        -- window setting
       (MkColor 43 43 43 255)                            -- background color
       1.0
       initDS
       showDS
       updateDS
