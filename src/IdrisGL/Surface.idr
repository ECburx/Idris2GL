{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Surface

import IdrisGL.SDLtypes
import IdrisGL.SDL_Support.SDL_surface

frgn : String -> String
frgn func = "C:" ++ func ++ ",surface"

-- +---------------+
-- | FFI functions |
-- +---------------+

-----------------------------------------------------------
-- | SDL_Surface *loadBMP(const char *path);
%foreign frgn "loadBMP"
prim_loadBMP : String -> Ptr SDL_Surface

-- | Uses this function to load a surface from a BMP file.
export
loadBMP : HasIO io => String -> io Sur
loadBMP path = pure $ MkSur $ prim_loadBMP path

-----------------------------------------------------------
-- | void blitSur(SDL_Surface *src, SDL_Surface *dst);
%foreign frgn "blitSur"
prim_blitSur : Ptr SDL_Surface -> Ptr SDL_Surface -> PrimIO ()

-- | Use this function to perform a fast surface copy to a destination surface.
export
blitSur : HasIO io => Sur -> Sur -> io ()
blitSur (MkSur src) (MkSur dst) = primIO $ prim_blitSur src dst