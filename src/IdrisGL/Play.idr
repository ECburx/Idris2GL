{- Tian Z (ecburx@burx.vip) -}

||| Play a game in a window.
module IdrisGL.Play

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.Color
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface
import IdrisGL.SDL.SDL_timer

||| Play a game in a window. Like simulate, but you manage your own input events.
|||
||| @ window  Display mode.
||| @ bgColor Background color.
||| @ tps     Frames per seconds control. (FPS) = 1/<value> (0: unlimited FPS)
||| @ w       The initial world.
||| @ w2p     A function to convert the world a picture.
||| @ ew2w    A function to handle input events.
||| @ tw2w    A function to step the world one iteration. It passes the amount of time (seconds) since the window creation.
export
play : (window  : Display)
    -> (bgColor : Color)
    -> (tps     : Double)
    ->  world
    -> (w2p     : (world  -> Picture))
    -> (ew2w    : (Eve    -> world -> world))
    -> (tw2w    : (Double -> world -> world))
    -> IO ()

play window bgColor tps w w2p ew2w tw2w = do
    win                            <- createWin window
    ren                            <- createRenderer win
    e                              <- newEve
    loop                              ren win e w 0
    closeWin                          win
    freeEve                           e
    freeRender                        ren
    where mutual
          loop : Renderer -> Win -> Event -> world -> Double -> IO ()
          loop ren win e world lastTime =
            if   !getSecondsTicks - lastTime < tps
            then loop'                ren win e world lastTime
            else do
              setRenderDrawColor      ren bgColor
              renderClear             ren
              loadPicture             (w2p world) ren win
              renderPresent           ren
              currT                <- getSecondsTicks
              let newW             =  tw2w currT world
              loop'                   ren win e newW currT

          loop' : Renderer -> Win -> Event -> world -> Double -> IO ()
          loop'   ren win e w lastTime with (eveType e)
            loop' _   _   _ _ _        | E_QUIT = pure ()
            loop' ren win e w lastTime | other  = loop ren win e (ew2w other w) lastTime