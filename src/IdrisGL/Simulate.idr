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
    e                           <-  newEve
    loop                           ren e !Sys.time m
    freeRender                     ren
    closeWin                       win
    where mutual
          loop : Renderer -> Event -> Integer -> model -> IO ()
          loop ren e lastTime model = 
            if   !Sys.time - lastTime < tps 
            then loop' ren e lastTime model
            else do
              setRenderDrawColor   ren bgColor
              renderClear          ren
              m2p model `loadPicture` ren
              renderPresent        ren
              currT             <- time
              let newM          =  m2m (currT - lastTime) model
              loop' ren e currT newM

          loop' : Renderer -> Event -> Integer -> model -> IO ()
          loop' ren e lastTime model = do
          case eveType e        of
               E_QUIT           => do freeEve e
                                      pure ()
               _                => loop ren e lastTime model