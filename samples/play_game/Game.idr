{- Tian Z (ecburx@burx.vip) -}

module Game

import IdrisGL

import World
import Map

{- Very simple RPG.
    W: Go up | S: Go down | A: Go left | D: Go right

   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "Game.idr"
   Game> :exec main
-}

main : IO ()
main =
    play (InWindow "RPG" (MkRect 50 50 (10*blockWidth) (10*blockWidth)))
         (MkColor 255 255 255 255)
       0.1            -- Frames per seconds (FPS) = 1/0.1 = 10 (0: unlimited FPS)
       initWorld
       showWD
       eventsHandler
       timeHandler