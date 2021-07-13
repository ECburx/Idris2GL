{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_event

import System.FFI

import IdrisGL.SDL.SDL_keycode

public export
data Eve 
  = E_UNAVAILABLE

  | E_QUIT

  | E_KEY Key

getEve : Int -> Eve
getEve 256        = E_QUIT
getEve 768        = E_KEY EK_UNKNOWN  -- SDL_KEYDOWN
-- getEve 769        = E_KEYUP   EK_UNKNOWN  -- SDL_KEYUP
getEve _          = E_UNAVAILABLE

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_events"

-- Event : Type
-- Event = Struct "event" [("e", AnyPtr), ("type", Int)]

--

%foreign frgn "pollEve"
prim_pollEve : Int

export
pollEve : Eve
pollEve = let code = prim_pollEve in
          case getEve code of
               E_UNAVAILABLE => E_KEY $ getKey code
               _             => getEve code