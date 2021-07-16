{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Play

import IdrisGL.Picture
import IdrisGL.DataType
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface
import IdrisGL.SDL.SDL_timer

export
play : Display                      -- Display mode.
    -> Color                        -- Background color.
    -> Double                       -- Time (seconds) of showing each step.
                                    --   (Moving to next steps after specified seconds.)
                                    --   Frames per seconds control. (FPS) = 1/<value> (0: unlimited FPS)
    -> world                        -- The initial world.
    -> (world  -> Picture)          -- A function to convert the world a picture.
    -> (Eve    -> world -> world)   -- A function to handle input events.
    -> (Double -> world -> world)   -- A function to step the world one iteration.
                                    --   It passes the amount of time (seconds) since the window creation.
    -> IO ()

play window bgColor tps w w2p ew2w tw2w = do
    win                            <- createWin window
    ren                            <- createRenderer win
    e                              <- newEve
    loop                              ren e w 0
    
    closeWin                          win
    freeEve                           e
    freeRender                        ren
    where mutual
          loop : Renderer -> Event -> world -> Double -> IO ()
          loop ren e world lastTime =
            if   !getSecondsTicks - lastTime < tps
            then loop'                ren e world lastTime
            else do
              setRenderDrawColor      ren bgColor
              renderClear             ren
              w2p world `loadPicture` ren
              renderPresent           ren
              currT                <- getSecondsTicks
              let newW             =  tw2w currT world
              loop'                   ren e newW currT
          
          loop' : Renderer -> Event -> world -> Double -> IO ()
          loop' ren e world lastTime = 
            case eveType e         of
               E_QUIT              => pure ()
               other               => do
                 let newW = ew2w other world
                 loop ren e newW lastTime