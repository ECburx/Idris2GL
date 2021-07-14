{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Play

import System as Sys

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface

export
play : Display -> Color
    -> Integer                      -- Time (seconds) of showing each step.
                                    --   (Moving to next steps after specified seconds.)
    -> world                        -- The initial world.
    -> (world   -> Picture)         -- A function to convert the world a picture.
    -> (Eve     -> world -> world)  -- A function to handle input events.
    -> (Integer -> world -> world)  -- A function to step the world one iteration.
                                    --   It passes the amount of time (seconds) since the window creation.
    -> IO ()

play window bgColor tps w w2p ew2w tw2w = do
    win                            <- createWin window
    ren                            <- createRenderer win
    e                              <- newEve
    startTime                      <- Sys.time
    loop                              ren e w startTime startTime
    closeWin                          win
    freeRender                        ren
    where mutual
          loop : Renderer -> Event -> world -> Integer -> Integer -> IO ()
          loop ren e world lastTime startTime = 
            if   !Sys.time - lastTime < tps
            then loop'                ren e world lastTime startTime
            else do
              setRenderDrawColor      ren bgColor
              renderClear             ren
              w2p world `loadPicture` ren
              renderPresent           ren
              currT                <- Sys.time
              let newW             =  tw2w (currT - startTime) world
              loop'                   ren e newW currT startTime
          
          loop' : Renderer -> Event -> world -> Integer -> Integer -> IO ()
          loop' ren e world lastTime startTime =
            case eveType e         of
               E_QUIT              => do 
                 freeEve e
                 pure ()
               other               => do
                 let newW = ew2w other world
                 loop ren e newW lastTime startTime
