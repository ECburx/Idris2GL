{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Preset

import IdrisGL.SDLtypes
import IdrisGL.SDL_Support.SDL_sysvideo

frgn : String -> String
frgn func = "C:" ++ func ++ ",preset"

-- +---------------+
-- | FFI functions |
-- +---------------+

-----------------------------------------------------------
-- void qLoadBMP(const char *path)
%foreign frgn "qLoadBMP"
prim_qLoadBMP : String -> PrimIO ()

-- | TODO
export
qLoadBMP : HasIO io => String -> io ()
qLoadBMP path = primIO $ prim_qLoadBMP path