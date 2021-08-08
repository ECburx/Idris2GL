{- Tian Z (ecburx@burx.vip) -}

module Mouse

import Control.Monad.State

import Data.Vect
import IdrisGL

{- Handle mouse events.
  
   $ idris2 -p idrisGL
   Main> :l "Mouse.idr"
   Mouse> :exec main
-}

font : String
font = "FreeSerif.ttf"

--              Mouse position  Time   Mouse state
data World = WD (Int,Int)       Double String

initWorld : World
initWorld = WD (0,0) 0 ""

showWD : World -> Picture
showWD (WD (x,y) t state) = 
    Pictures [Text   posMsg  16 font (MkCoor 40 40) Color.black
             ,Text   state   16 font (MkCoor 40 70) Color.black
             ,Text   timeMsg 16 font (MkCoor 10 10) Color.black
             ,Circle (MkCoor x y) Color.black False 10]
    where posMsg : String
          posMsg  = "Mouse Position: (" ++ show x ++ ", " ++ show y ++ ")"
          timeMsg : String
          timeMsg = "Timer: " ++ show t ++ "s"

eventsHandler : Eve -> World -> World
eventsHandler (E_MOUSEMOTION       (x,y)) (WD _ t _) = WD (x,y) t "Mouse Motion."
eventsHandler (E_L_MOUSEBUTTONDOWN (x,y)) (WD _ t _) = WD (x,y) t "Mouse Button Down."
eventsHandler (E_L_MOUSEBUTTONUP   (x,y)) (WD _ t _) = WD (x,y) t "Mouse Button Up."
eventsHandler (E_MOUSEWHEEL        (x,y)) (WD _ t _) = WD (x,y) t "Mouse Wheel."
eventsHandler _ w = w

timeHandler : Double -> World -> World
timeHandler t (WD xy _ s) = WD xy t s

main : IO ()
main =
    play (InWindow "Mouse" (MkRect 50 50 300 120)) -- window setting
         Color.white                               -- background color
         0.01                                      -- Frames per seconds (FPS) = 1/0.01 = 100 (0: unlimited FPS)
         initWorld
         showWD
         eventsHandler
         timeHandler

{- 

  Play a game with mutable states. 

-}

showST : StateT World IO Picture
showST = do
    (WD pos@(x,y) t state) <- get
    pure $ Pictures [Text   (posMsg pos) 16 font (MkCoor 40 40) Color.black
                    ,Text   state        16 font (MkCoor 40 70) Color.black
                    ,Text   (timeMsg t)  16 font (MkCoor 10 10) Color.black
                    ,Circle (MkCoor x y) Color.black False 10]
    where posMsg : (Int, Int) -> String
          posMsg (x, y) = "Mouse Position: (" ++ show x ++ ", " ++ show y ++ ")"
          timeMsg : Double -> String
          timeMsg t = "Timer: " ++ show t ++ "s"

eventsSTHandler : (event : Eve) -> StateT World IO ()
eventsSTHandler event = do
  world@(WD _ t _) <- get
  case event of
       E_MOUSEMOTION       pos => put $ WD pos t "Mouse Motion."
       E_L_MOUSEBUTTONDOWN pos => put $ WD pos t "Mouse Button Down."
       E_L_MOUSEBUTTONUP   pos => put $ WD pos t "Mouse Button Up."
       E_MOUSEWHEEL        pos => put $ WD pos t "Mouse Wheel."
       _                       => put world

timeSTHandler : (t : Double) -> StateT World IO ()
timeSTHandler t = do
  WD pos _ mouse <- get
  put $ WD pos t mouse

mainST : IO ()
mainST = playStateT
          (InWindow "Mouse" (MkRect 50 50 300 120))
          Color.white
          0.01 -- Frames per seconds (FPS) = 1/0.01 = 100 (0: unlimited FPS)
          initWorld
          showST
          eventsSTHandler
          timeSTHandler