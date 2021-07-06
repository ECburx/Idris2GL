{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_event

import IdrisGL.SDL.SDL_keycode

public export
data Eve 
  = E_UNAVAILABLE

  | E_QUIT

  | E_KEY Key

getEve : Int -> Eve
getEve 256        = E_QUIT
getEve 768        = E_KEY EK_UNKNOWN
getEve _          = E_UNAVAILABLE

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_events"

--

%foreign frgn "pollEve"
prim_pollEve : Int

export
pollEve : Eve
pollEve = let code = prim_pollEve in
          case getEve code of
               E_UNAVAILABLE => E_KEY $ getKey code
               _             => getEve code