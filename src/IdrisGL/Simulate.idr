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
                                        --   It passes the amount of time (seconds) since the window creation.
        -> IO ()

simulate window bgColor tps m m2p m2m = do
    win                         <- createWin window
    ren                         <- createRenderer win
    e                           <- newEve
    startTime                   <- Sys.time
    loop                           ren e m startTime startTime
    closeWin                       win
    freeRender                     ren
    where mutual
          loop : Renderer -> Event -> model -> Integer -> Integer -> IO ()
          loop ren e model lastTime startTime = 
            if   !Sys.time - lastTime < tps 
            then loop' ren e model lastTime startTime
            else do
              setRenderDrawColor   ren bgColor
              renderClear          ren
              m2p model `loadPicture` ren
              renderPresent        ren
              currT             <- time
              let newM          =  m2m (currT - startTime) model
              loop' ren e newM currT startTime

          loop' : Renderer -> Event -> model -> Integer -> Integer -> IO ()
          loop' ren e model lastTime startTime = do
          case eveType e        of
               E_QUIT           => do freeEve e
                                      pure ()
               _                => loop ren e model lastTime startTime