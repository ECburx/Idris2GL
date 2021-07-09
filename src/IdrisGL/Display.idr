{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Display

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface

export
display : Display -> Color -> Picture -> IO ()
display window bgColor pic =  do 
    win                    <- createWin window
    ren                    <- createRenderer win
    setRenderDrawColor        ren bgColor

    renderClear               ren
    loadPicture pic           ren
    renderPresent             ren
    loop

    freeRender                ren
    closeWin                  win

    where loop : IO ()
          loop             = 
          case pollEve     of
               E_QUIT      => pure ()
               _           => loop