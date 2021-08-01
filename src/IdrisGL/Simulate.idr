{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Simulate

import Control.Monad.State

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
||| @ tpf     Time per frame. Providing frames per seconds control. (FPS) = 1/<value> (0: unlimited FPS)
||| @ model   The initial model.
||| @ m2p     Function to step the model one iteration.
||| @ m2m     A function to step the model one iteration. It passes the amount of time (seconds) since the window creation.
export
simulate 
  :  (window  : Display)
  -> (bgColor : Color)
  -> (tpf     : Double)
  -> model
  -> (m2p     : (model  -> Picture))
  -> (m2m     : (Double -> model -> model))
  -> IO ()

simulate window bgColor tps m m2p m2m = do
    win                   <- createWin window
    ren                   <- createRenderer win
    e                     <- newEve
    loop                     ren win e m 0
    closeWin                 win
    freeEve                  e
    freeRender               ren
where mutual
      loop : Renderer -> Win -> Event -> model -> Double -> IO ()
      loop ren win e model lastTime = 
        if   !getSecondsTicks - lastTime < tps
        then loop'           ren win e model lastTime
        else do
          setRenderDrawColor ren bgColor
          renderClear        ren
          loadPicture        (m2p model) ren win
          renderPresent      ren
          currT           <- getSecondsTicks
          let newM        =  m2m currT model
          loop' ren win e newM currT

      loop' : Renderer -> Win -> Event -> model -> Double -> IO ()
      loop'   ren win e m lastTime with (eveType e)
        loop' _   _   _ _ _        | E_QUIT = pure ()
        loop' ren win e m lastTime | _      = loop ren win e m lastTime

||| Run a simulation with mutable state in a window.
|||
||| @ window  Display mode.
||| @ bgColor Background color.
||| @ tpf     Time per frame. Providing frames per seconds control. (FPS) = 1/<value> (0: unlimited FPS)
||| @ model   The initial model.
||| @ m2p     Describes how to produce pictures to show.
||| @ m2m     A stateful function to step the model one iteration. It passes the amount of time (seconds) since the window creation.
export
simulateState
  :  (window  : Display)
  -> (bgColor : Color)
  -> (tpf     : Double)
  -> stateType
  -> (m2p     : StateT stateType IO Picture)
  -> (m2m     : Double -> StateT stateType IO ())
  -> IO ()

simulateState window bgColor tps state m2p m2m = do
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
        if   !getSecondsTicks - lastTime < tps
        then loop'           st ren win e lastTime
        else do
          setRenderDrawColor ren bgColor
          renderClear        ren
          (st, pics)      <- runStateT st m2p
          loadPicture        pics ren win
          renderPresent      ren
          currT           <- getSecondsTicks
          st              <- execStateT st (m2m currT)
          loop'              st ren win e currT

      loop' : stateType -> Renderer -> Win -> Event -> Double -> IO ()
      loop'   st ren win e lastTime with (eveType e)
        loop' _  _   _   _ _        | E_QUIT = pure ()
        loop' st ren win e lastTime | _      = loop st ren win e lastTime
