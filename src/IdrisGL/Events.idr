{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Events

import IdrisGL.SDLtypes
import IdrisGL.SDL_Support.SDL_keycode
import System.FFI

frgn : String -> String
frgn func = "C:" ++ func ++ ",events"

public export
data Eve 
  = E_UNAVAILABLE

  | E_QUIT

  | E_KEY Key

-- +---------------+
-- | FFI functions |
-- +---------------+

EventStruct : Type
EventStruct
    = Struct "EventStruct"
    [("eventCode"       , Int)
    ,("event"           , AnyPtr)     -- SDL_Event*
    ]

getEve : Int -> Eve
getEve 256        = E_QUIT
getEve 768        = E_KEY EK_UNKNOWN
getEve _          = E_UNAVAILABLE

-----------------------------------------------------------
-- EventStruct *pollEve();
%foreign frgn "pollEve"
prim_pollEve : Int

-- | Poll for currently pending events.
export
pollEve : Eve
pollEve = let code = prim_pollEve in
          case getEve code of
               E_UNAVAILABLE => E_KEY $ getKey code
               _             => getEve code