{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Animate

import System as Sys

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface
import IdrisGL.SDL.SDL_timer

export
animate : Display -> Color -> (Integer -> Picture)-> IO ()
animate window bgColor picF             =  do
    win                                 <- createWin window
    ren                                 <- createRenderer win
    loop                                   ren picF bgColor !Sys.time
    freeRender                             ren
    closeWin                               win
    where
        loop : Renderer -> (Integer -> Picture) -> Color -> Integer -> IO ()
        loop ren picF bgColor startTime =  do
            setRenderDrawColor             ren bgColor
            renderClear                    ren
            let s                       =  !Sys.time - startTime
            picF s `loadPicture`           ren
            renderPresent                  ren
            delayWin                       10
            case pollEve                of
                 E_QUIT                 => pure ()
                 _                      => loop ren picF bgColor startTime