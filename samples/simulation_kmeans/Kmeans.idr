{- Tian Z (ecburx@burx.vip) -}

module Kmeans

import IdrisGL
import IdrisGL.Random

import Data.Vect

{- Kmeans.
   k-means clustering.

   $ idris2 -p idrisGL
   Main> :l "Kmeans.idr"
   Kmeans> :exec main
-}

||| A data unit in dataset.
data UNIT = Ut Int Int Color

||| A dataset with n units and k sets.
data DataSet : (k : Nat) -> Type where
     DS : (units : Vect n UNIT) -> (means : Vect k UNIT) -> DataSet k

-- The maximum possible value of a data.
maxData : Int
maxData = 300

-- Initial dataset with k = 3.
initDS : DataSet 3
initDS = 
      -- Units in white haven't belong to any set.
   DS [Ut 358 276 white, Ut 181 143 white, Ut 87   34 white, Ut 295  25 white, Ut 388 139 white
      ,Ut 390 293 white, Ut 404 225 white, Ut 228  89 white, Ut 145  59 white, Ut 371  61 white
      ,Ut 368 207 white, Ut 259 283 white, Ut 320 158 white, Ut 202 126 white, Ut 323  96 white
      ,Ut 155 112 white, Ut 229 187 white, Ut 223 225 white, Ut 304 190 white, Ut 339  54 white
      ,Ut 334 118 white, Ut 143 144 white, Ut 226 262 white, Ut 375 273 white, Ut 273 129 white
      ,Ut  85 160 white, Ut 156 222 white, Ut 109 154 white, Ut 255 221 white, Ut 207 275 white]
      {-
         Initial means of three sets.
         (red, green, blue) Each color represents means of one set.
         They are randomly generated within the data domain. (Predictable randomness only for testing.)
      -}
      [Ut (randomInt 0 maxData) (randomInt 0 maxData) red
      ,Ut (randomInt 0 maxData) (randomInt 0 maxData) green
      ,Ut (randomInt 0 maxData) (randomInt 0 maxData) blue]

-- A function to display a dataset.
showDS : DataSet k -> Picture
showDS (DS units means) = 
   let frame     = Rectangle (MkRect 10 10 480 300) (MkRGB 60 60 60) True
       unitsPics = toList $ map u2p units
       meansPics = toList $ map m2p means
   in  Pictures $ frame :: meansPics ++ unitsPics
where -- Radius of pins.
      radius : Int
      radius = 5

      u2p : UNIT -> Picture
      u2p (Ut x y color) = Circle (MkCoor x y) color False radius

      m2p : UNIT -> Picture
      m2p (Ut x y color) = Pictures
         [ThickLine (MkCoor (x-radius) (y-radius)) (MkCoor (x+radius) (y+radius)) color 3 
         ,ThickLine (MkCoor (x-radius) (y+radius)) (MkCoor (x+radius) (y-radius)) color 3]      

-- A function to step a dataset. Ignoring the time.
updateDS : Double -> DataSet k -> DataSet k
updateDS _ (DS units means) =
   let newUnits = (\u => belong u means (ipow2 maxData)) <$> units
       newMeans = (\m => updateMean m newUnits) <$> means
   in  DS newUnits newMeans
where ipow2 : Int -> Int
      ipow2 a = a * a

      -- Update the color of a data unit to that of the nearest means.
      -- @ d2 The square of the distance between unit and nearest means.
      belong : (unit : UNIT) -> (means : Vect m UNIT) -> (d2 : Int) -> UNIT
      belong unit Nil _ = unit
      belong unit@(Ut ux uy _) (Ut mx my color::means') d2 = 
         let  d' = ipow2 (ux-mx) + ipow2 (uy-my) in
         if   d' < d2
         then belong (Ut ux uy color) means' d'
         else belong unit means' d2

      -- Calculate the coordinate sum and quantity of the data belonging to a certain cluster.
      -- @ mean The cluster's centroid.
      xySum : (mean : UNIT) -> (units : Vect n UNIT) -> (Int, Int, Int)
      xySum _ [] = (0,0,0)
      xySum k@(Ut _ _ uColor) (Ut x y kColor::us) =
         let  (xs, ys, num) = xySum k us in
         if   uColor == kColor
         then (xs+x, ys+y, num+1)
         else (xs  , ys  , num  )

      -- Update position of one mean.
      updateMean : (mean : UNIT) -> (units : Vect n UNIT) -> UNIT
      updateMean mean@(Ut _ _ color) units =
         case xySum mean units of
            (xs, ys, 0)   => mean
            (xs, ys, num) => Ut (div xs num) (div ys num) color

main : IO ()
main = 
   simulate
       (InWindow "Kmeans" (MkRect 50 50 500 320))
       (MkRGB 43 43 43)
       1
       initDS
       showDS
       updateDS
