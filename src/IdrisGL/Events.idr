{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Events

import IdrisGL.SDLtypes

frgn : String -> String
frgn func = "C:" ++ func ++ ",events"

-- +---------------+
-- | FFI functions |
-- +---------------+

-----------------------------------------------------------
-- | SDL_Event *nullEve();
%foreign frgn "nullEve"
prim_nullEve : Ptr SDL_Event

export
nullEve : HasIO io => io Eve
nullEve = pure $ MkEve $ prim_nullEve

-----------------------------------------------------------
-- | int evePending(SDL_Event *eve);
%foreign frgn "evePending"
prim_evePending : Ptr SDL_Event -> Int

export
evePending : Eve -> Bool
evePending (MkEve e) = 
    case prim_evePending e of
         0 => False
         _ => True

-----------------------------------------------------------
-- | int eveQuit(SDL_Event *eve);
%foreign frgn "eveQuit"
prim_eveQuit : Ptr SDL_Event -> Int

export
eveQuit : Eve -> Bool
eveQuit (MkEve e) = 
    case prim_eveQuit e of
         1 => True
         _ => False