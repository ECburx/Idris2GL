{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Display

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.Color
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface
import IdrisGL.SDL.SDL_timer

export
display : Display                   -- Display mode.
       -> Color                     -- Background color.
       -> Picture 
       -> IO ()
display window bgColor pic  =  do 
    win                     <- createWin window
    ren                     <- createRenderer win
    setRenderDrawColor         ren bgColor

    renderClear                ren
    loadPicture                pic ren win
    renderPresent              ren
    e                       <- newEve
    loop                       e

    closeWin                   win
    freeEve e
    freeRender                 ren

    where loop : Event -> IO ()
          loop e            =
          case eveType e    of
               E_QUIT       => pure ()
               _            => loop e