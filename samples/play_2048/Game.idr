{- Tian Z (ecburx@burx.vip) -}

module Game

import IdrisGL
import IdrisGL.Random

import Tile
import World

{- Play 2048.
   Materials from https://play2048.co/.
  
   $ idris2 -p idrisGL
   Main> :l "Game.idr"
   Game> :exec main
-}

window : Display
window = InWindow "2048" (MkRect 100 100 width height)
where width : Int
      width = 4 * (tileWidth + tileSpacing) + tileSpacing
      height : Int
      height = width + 40 -- The height of score bar

main : IO ()
main = 
    playStateT window
         (MkRGB 187 173 160)
         0.1 -- Frames per seconds (FPS) = 1/0.1 = 10 (0: unlimited FPS)
         initWorld
         showWorld
         eventsHandler
         timeHandler