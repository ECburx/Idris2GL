{- Tian Z (ecburx@burx.vip) -}

||| Play a game in a window.
module IdrisGL.Play

import Control.Monad.State

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
||| @ tpf     Time per frame. Providing frames per seconds control. (FPS) = 1/<value> (0: unlimited FPS)
||| @ w       The initial world.
||| @ w2p     A function to convert the world to a picture.
||| @ ew2w    A function to handle input events.
||| @ tw2w    A function to step the world one iteration. It passes the amount of time (seconds) since the window creation.
export
play : (window  : Display)
    -> (bgColor : Color)
    -> (tpf     : Double)
    -> world
    -> (w2p     : world  -> Picture)
    -> (ew2w    : Eve    -> world -> world)
    -> (tw2w    : Double -> world -> world)
    -> IO ()
play window bgColor tpf w w2p ew2w tw2w = do
    win                   <- createWin window
    ren                   <- createRenderer win
    e                     <- newEve
    loop                     ren win e w 0
    closeWin                 win
    freeEve                  e
    freeRender               ren
where mutual
      loop : Renderer -> Win -> Event -> world -> Double -> IO ()
      loop ren win e world lastTime =
        if   !getSecondsTicks - lastTime < tpf
        then loop'           ren win e world lastTime
        else do
          setRenderDrawColor ren bgColor
          renderClear        ren
          loadPicture        (w2p world) ren win
          renderPresent      ren
          currT           <- getSecondsTicks
          let newW        =  tw2w currT world
          loop'              ren win e newW currT

      loop' : Renderer -> Win -> Event -> world -> Double -> IO ()
      loop'   ren win e w lastTime with (eveType e)
        loop' _   _   _ _ _        | E_QUIT = pure ()
        loop' ren win e w lastTime | other  = loop ren win e (ew2w other w) lastTime


||| Play a game with mutable state in a window. 
||| Like simulate, but you manage your own input events.
|||
||| @ window    Display mode.
||| @ bgColor   Background color.
||| @ tpf       Time per frame. Providing frames per seconds control. (FPS) = 1/<value> (0: unlimited FPS)
||| @ stateType The initial world.
||| @ w2p       Describes how to produce pictures to show.
||| @ e2w       A stateful function that handles input events.
||| @ t2w       A stateful function that handles the amount of time (seconds) since the window creation.
export
playState 
  :  (window  : Display)
  -> (bgColor : Color)
  -> (tpf     : Double)
  -> stateType
  -> (w2p     : StateT stateType IO Picture)
  -> (e2w     : Eve    -> StateT stateType IO ())
  -> (t2w     : Double -> StateT stateType IO ())
  -> IO ()
playState window bgColor tpf state w2p e2w t2w = do
    win                   <- createWin window
    ren                   <- createRenderer win
    e                     <- newEve
    loop                     state ren win e 0
    closeWin                 win
    freeEve                  e
    freeRender               ren
where mutual
      loop : stateType -> Renderer -> Win -> Event -> Double -> IO ()
      loop st ren win e lastTime =
        if   !getSecondsTicks - lastTime < tpf
        then loop'           st ren win e lastTime
        else do
          setRenderDrawColor ren bgColor
          renderClear        ren
          (st, pics)      <- runStateT st w2p
          loadPicture        pics ren win
          renderPresent      ren
          currT           <- getSecondsTicks
          st              <- execStateT st (t2w currT)
          loop'              st ren win e currT

      loop' : stateType -> Renderer -> Win -> Event -> Double -> IO ()
      loop'   st ren win e lastTime with (eveType e)
        loop' _  _   _   _ _        | E_QUIT = pure ()
        loop' st ren win e lastTime | other  = do
          st              <- execStateT st (e2w other)
          loop               st ren win e lastTime