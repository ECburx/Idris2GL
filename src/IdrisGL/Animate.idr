{- Tian Z (ecburx@burx.vip) -}

||| Animate a picture in a window.
module IdrisGL.Animate

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.Color
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface
import IdrisGL.SDL.SDL_timer

||| Open a new window and display the given animation.
|||
||| @ window  Display mode.
||| @ bgColor Background color.
||| @ tpf     Time per frame. Providing frames per seconds control. (FPS) = 1/<value> (0: unlimited FPS)
||| @ picF    Function to produce the next frame of animation. It is passed the time in seconds since the program started.
export
animate : (window  : Display)
       -> (bgColor : Color)
       -> (tpf     : Double)
       -> (picF    : (Double -> Picture))
       -> IO ()
animate window bgColor tps picF = do
    win                      <- createWin window
    ren                      <- createRenderer win
    e                        <- newEve
    loop                        ren win e 0
    closeWin                    win
    freeEve                     e
    freeRender                  ren
    where mutual
        loop : Renderer -> Win -> Event -> Double -> IO ()
        loop ren win e lastTime =
            if   !getSecondsTicks - lastTime < tps
            then loop'          ren win e lastTime
            else do
            setRenderDrawColor  ren bgColor
            renderClear         ren
            loadPicture         (picF !getSecondsTicks) ren win
            renderPresent       ren
            loop'               ren win e !getSecondsTicks

        loop' : Renderer -> Win -> Event -> Double -> IO ()
        loop'     ren win e lastTime with (eveType e)
            loop' _   _   _ _        | E_QUIT = pure ()
            loop' ren win e lastTime | _      = loop ren win e lastTime
            