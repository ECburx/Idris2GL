{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Simulate

import System as Sys

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface

export
simulate : Display -> Color 
         -> Integer                     -- Time (seconds) of showing each step.
                                        --   (Moving to next steps after specified seconds.)
         -> model                       -- The initial model.
         -> (model -> Picture)          -- Function to step the model one iteration.
         -> (Integer -> model -> model) -- A function to step the model one iteration. 
                                        --   It passes the amount of time (ms) for this simulation step
                                        --   (Time spent in the last iteration).
                                        --   This is often useful when the model is not changing at a constant rate.
         -> IO ()

simulate window bgColor tps m m2p m2m = do
    win                         <- createWin window
    ren                         <- createRenderer win
    loop                           ren !Sys.time tps m m2p m2m
    freeRender                     ren
    closeWin                       win
    where mutual
          loop : Renderer -> Integer -> Integer                             -- Renderer -> Last Timestamp -> Time for one step
              -> model -> (model -> Picture) -> (Integer -> model -> model) 
              -> IO ()
          loop ren lastTime tps m m2p m2m = 
            if   !Sys.time - lastTime < tps 
            then loop' ren lastTime tps m m2p m2m
            else do
              setRenderDrawColor   ren bgColor
              renderClear          ren
              m2p m `loadPicture`  ren
              renderPresent        ren
              currT             <- time
              let newM          =  m2m (currT - lastTime) m
              loop' ren currT tps newM m2p m2m

          loop' : Renderer -> Integer -> Integer
               -> model -> (model -> Picture) -> (Integer -> model -> model) 
               -> IO ()
          loop' ren lastTime tps m m2p m2m = 
            case pollEve        of
                 E_QUIT         => pure ()
                 _              => loop ren lastTime tps m m2p m2m