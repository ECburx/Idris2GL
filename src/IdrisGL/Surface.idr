{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Surface

import IdrisGL.SDLtypes
import IdrisGL.SDL_Support.SDL_surface
import IdrisGL.SDL_Support.SDL_rect
import IdrisGL.SDL_Support.SDL_sysvideo

frgn : String -> String
frgn func = "C:" ++ func ++ ",surface"

-- +---------------+
-- | FFI functions |
-- +---------------+

-----------------------------------------------------------
-- | SDL_Surface *loadBMP(const char *path);
%foreign frgn "loadBMPSur"
prim_loadBMPSur : String -> Ptr SDL_Surface

-- | Uses this function to load a surface from a BMP file.
export
loadBMPSur : HasIO io => String -> io Sur
loadBMPSur path = pure $ MkSur $ prim_loadBMPSur path

-----------------------------------------------------------
-- | void blitSur(SDL_Surface *src, SDL_Surface *dst);
%foreign frgn "blitSur"
prim_blitSur : Ptr SDL_Surface -> Ptr SDL_Surface -> PrimIO ()

-- | Use this function to perform a fast surface copy to a destination surface.
export
blitSur : HasIO io => Sur -> Sur -> io ()
blitSur (MkSur src) (MkSur dst) = primIO $ prim_blitSur src dst

-----------------------------------------------------------
-- | void blitSurRect(SDL_Surface *src, SDL_Rect *srcRect, SDL_Surface *dst, SDL_Rect *dstRect);
%foreign frgn "blitSurRect"
prim_blitSurRect : Ptr SDL_Surface -> Ptr SDL_Rect -> Ptr SDL_Surface -> Ptr SDL_Rect -> PrimIO ()

-- | Use this function to perform a fast surface copy to a destination surface, with area specified.
export
blitSurRect : HasIO io => Sur -> Rect -> Sur -> Rect -> io ()
blitSurRect (MkSur src) (MkRect srcRect) (MkSur dst) (MkRect dstRect) 
    = primIO $ prim_blitSurRect src srcRect dst dstRect