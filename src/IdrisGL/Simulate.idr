{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Simulate

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.Color
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface
import IdrisGL.SDL.SDL_timer

||| Run a simulation in a window.
|||
||| @ window  Display mode.
||| @ bgColor Background color.
||| @ tps     Frames per seconds control. (FPS) = 1/<value> (0: unlimited FPS)
||| @ model   The initial model.
||| @ m2p     Function to step the model one iteration.
||| @ m2m     A function to step the model one iteration. It passes the amount of time (seconds) since the window creation.
export
simulate : (window  : Display)
        -> (bgColor : Color)
        -> (tps     : Double)
        -> model
        -> (m2p     : (model  -> Picture))
        -> (m2m     : (Double -> model -> model))
        -> IO ()

simulate window bgColor tps m m2p m2m = do
    win                         <- createWin window
    ren                         <- createRenderer win
    e                           <- newEve
    loop                           ren win e m 0
    closeWin                       win
    freeEve                        e
    freeRender                     ren
    where mutual
          loop : Renderer -> Win -> Event -> model -> Double -> IO ()
          loop ren win e model lastTime = 
            if   !getSecondsTicks - lastTime < tps
            then loop'             ren win e model lastTime
            else do
              setRenderDrawColor   ren bgColor
              renderClear          ren
              loadPicture          (m2p model) ren win
              renderPresent        ren
              currT             <- getSecondsTicks
              let newM          =  m2m currT model
              loop' ren win e newM currT

          loop' : Renderer -> Win -> Event -> model -> Double -> IO ()
          loop' ren win e model lastTime =
          case eveType e        of
               E_QUIT           => pure ()
               _                => loop ren win e model lastTime