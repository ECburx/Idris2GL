{- Tian Z (ecburx@burx.vip) -}

module Clock

import IdrisGL

{- Clock.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "Clock.idr"
   Clock> :exec main
-}

font : String
font = "FreeSerif.ttf"

black : Color
black = MkColor 0 0 0 255

-- | The center of the clock.
center : Coordinate
center = MkCoor 150 150

clock_Hand : Int        -- Dividing the clock into 60 parts, this integer represents which part the hand points to.
          -> Int        -- The length of a clock hand.
          -> Int        -- The thickness of a clock hand.
          -> Picture
clock_Hand time length thickness =
    ThickLine center (MkCoor x y) black thickness
    where angle : Double
          angle = (cast $ mod time 60) * pi / 30
          x     : Int 
          x     = cast $ 150.0 + sin angle * (cast length)
          y     : Int
          y     = cast $ 150.0 - cos angle * (cast length)

clock_Text : Int -> Picture
clock_Text time = SolidText (show h ++ ":" ++ show m ++ ":" ++ show s)
                    20 font (MkCoor 10 10) black TS_BOLD TH_MONO 0
    where s : Int
          s = time `mod` 60
          m : Int
          m = mod (div time 60) 60
          h : Int
          h = mod (div time 1200) 60

clock_Number : List Picture
clock_Number 
    = [f "XII" 130 25
      ,f "III" 232 130
      ,f "VI"  132 230
      ,f "IX"  37  130]
      where f : String -> Int -> Int -> Picture
            f str x y = SolidText str 30 font (MkCoor x y) black TS_NORMAL TH_MONO 0

clock : Double -> Picture
clock s = let s' : Int = cast s in
            Pictures ([Circle     center black False 120
                    ,clock_Hand s'                   90  1    -- second
                    ,clock_Hand (cast $ div s' 60)   70  4    -- minute
                    ,clock_Hand (cast $ div s' 1200) 50  6    -- hour
                    ,clock_Text s'] ++ clock_Number)

main : IO ()
main = animate 
       (InWindow "Clock" (MkRect 50 50 300 300))        -- window setting
       (MkColor 255 255 255 255)                        -- background color
       1                                                -- FPS control
       clock                                            -- Function to produce the next frame of animation.
                                                        -- It is passed the time in seconds since the program started.