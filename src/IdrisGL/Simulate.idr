{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Simulate

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface
import IdrisGL.SDL.SDL_timer

export
simulate : Display                      -- Display mode.
        -> Color                        -- Background color.
        -> Double                       -- Time (seconds) of showing each step.
                                        --   (Moving to next steps after specified seconds.)
                                        --   Frames per seconds control. (FPS) = 1/<value> (0: unlimited FPS)
        -> model                        -- The initial model.
        -> (model  -> Picture)          -- Function to step the model one iteration.
        -> (Double -> model -> model)   -- A function to step the model one iteration. 
                                        --   It passes the amount of time (seconds) since the window creation.
        -> IO ()

simulate window bgColor tps m m2p m2m = do
    win                         <- createWin window
    ren                         <- createRenderer win
    e                           <- newEve
    loop                           ren e m 0
    closeWin                       win
    freeEve                        e
    freeRender                     ren
    where mutual
          loop : Renderer -> Event -> model -> Double -> IO ()
          loop ren e model lastTime = 
            if   !getSecondsTicks - lastTime < tps
            then loop' ren e model lastTime
            else do
              setRenderDrawColor   ren bgColor
              renderClear          ren
              m2p model `loadPicture` ren
              renderPresent        ren
              currT             <- getSecondsTicks
              let newM          =  m2m currT model
              loop' ren e newM currT

          loop' : Renderer -> Event -> model -> Double -> IO ()
          loop' ren e model lastTime =
          case eveType e        of
               E_QUIT           => pure ()
               _                => loop ren e model lastTime