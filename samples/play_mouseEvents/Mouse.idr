{- Tian Z (ecburx@burx.vip) -}

module Mouse

import IdrisGL

{- Handle mouse events.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "Mouse.idr"
   Mouse> :exec main
-}

font : String
font = "FreeSerif.ttf"

black : Color
black = MkColor 0 0 0 255 

--              Mouse position  Time  Mouse state
data World = WD (Int,Int)       Int   String

initWorld : World
initWorld = WD (0,0) 0 ""

showWD : World -> Picture
showWD (WD (x,y) t state) = 
    Pictures [Text   posMsg  16 font (MkCoor 40 40) black
             ,Text   state   16 font (MkCoor 40 70) black
             ,Text   timeMsg 16 font (MkCoor 10 10) black
             ,Circle (MkCoor x y) black False 10]
    where posMsg : String
          posMsg  = "Mouse Position: (" ++ show x ++ ", " ++ show y ++ ")"
          timeMsg : String
          timeMsg = "Timer: " ++ show t ++ "s"

eventsHandler : Eve -> World -> World
eventsHandler (E_MOUSEMOTION     (x,y)) (WD _ t _) = WD (x,y) t "Mouse Motion."
eventsHandler (E_MOUSEBUTTONDOWN (x,y)) (WD _ t _) = WD (x,y) t "Mouse Button Down."
eventsHandler (E_MOUSEBUTTONUP   (x,y)) (WD _ t _) = WD (x,y) t "Mouse Button Up."
eventsHandler (E_MOUSEWHEEL      (x,y)) (WD _ t _) = WD (x,y) t "Mouse Wheel."
eventsHandler _ w = w

timeHandler : Integer -> World -> World
timeHandler t (WD xy _ s) = WD xy (cast t) s

main : IO ()
main = do
    play (InWindow "Kmeans" (MkRect 50 50 300 120))        -- window setting
         (MkColor 255 255 255 255)                         -- background color
       0                                                   -- set to 0 to show continuous animation.
       initWorld
       showWD
       eventsHandler
       timeHandler