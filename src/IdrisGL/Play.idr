{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Play

import System as Sys

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface

export
play : Display -> Color
    -> Integer                      -- Time (seconds) of showing each step.
                                    --   (Moving to next steps after specified seconds.)
    -> world                        -- The initial world.
    -> (world   -> Picture)         -- A function to convert the world a picture.
    -> (Eve     -> world -> world)  -- A function to handle input events.
    -> (Integer -> world -> world)  -- A function to step the world one iteration.
                                    --   It passes the amount of time (ms) for this simulation step
                                    --   (Time spent in the last iteration).
                                    --   This is often useful when the world is not changing at a constant rate.
    -> IO ()

play window bgColor tps w w2p ew2w tw2w = do
    win                            <- createWin window
    ren                            <- createRenderer win
    loop                              ren !Sys.time w
    freeRender                        ren
    closeWin                          win
    where mutual
          loop : Renderer -> Integer -> world -> IO ()
          loop ren lastTime world  = 
            if   !Sys.time - lastTime < tps 
            then loop'                ren lastTime world
            else do
              setRenderDrawColor      ren bgColor
              renderClear             ren
              w2p world `loadPicture` ren
              renderPresent           ren
              currT                <- time
              let newW             =  tw2w (currT - lastTime) world
              loop'                   ren currT newW
          
          loop' : Renderer -> Integer -> world -> IO ()
          loop' ren lastTime world =  loop ren lastTime (ew2w pollEve world)
