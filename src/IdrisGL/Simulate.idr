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
        -> Integer                      -- Time (seconds) of showing each step.
                                        --   (Moving to next steps after specified seconds.)
        -> model                        -- The initial model.
        -> (model -> Picture)           -- Function to step the model one iteration.
        -> (Integer -> model -> model)  -- A function to step the model one iteration. 
                                        --   It passes the amount of time (ms) for this simulation step
                                        --   (Time spent in the last iteration).
                                        --   This is often useful when the model is not changing at a constant rate.
        -> IO ()

simulate window bgColor tps m m2p m2m = do
    win                         <- createWin window
    ren                         <- createRenderer win
    loop                           ren !Sys.time m
    freeRender                     ren
    closeWin                       win
    where mutual
          loop : Renderer -> Integer -> model -> IO ()
          loop ren lastTime model = 
            if   !Sys.time - lastTime < tps 
            then loop' ren lastTime model
            else do
              setRenderDrawColor   ren bgColor
              renderClear          ren
              m2p model `loadPicture` ren
              renderPresent        ren
              currT             <- time
              let newM          =  m2m (currT - lastTime) model
              loop' ren currT newM

          loop' : Renderer -> Integer -> model -> IO ()
          loop' ren lastTime model = 
            case pollEve        of
                 E_QUIT         => pure ()
                 _              => loop ren lastTime model