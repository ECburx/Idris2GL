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
-- SDL_Surface *loadBMP(const char *path);
%foreign frgn "loadBMPSur"
prim_loadBMPSur : String -> Ptr SDL_Surface

-- | Uses this function to load a surface from a BMP file.
export
loadBMPSur : HasIO io => String -> io Sur
loadBMPSur path = pure $ MkSur $ prim_loadBMPSur path

-----------------------------------------------------------
-- void loadBMP2Win(SDL_Window *win, const char *path, int x, int y, int w, int h);
%foreign frgn "loadBMP2Win"
prim_loadBMP2Win : Ptr SDL_Window -> String -> Int -> Int -> Int -> Int -> PrimIO ()

-- | Loads and shows a bmp file in a window.
export
loadBMP2Win : HasIO io => Win -> String -> Rect -> io ()
loadBMP2Win (MkWin win) path (MkRect x y w h) = primIO $ prim_loadBMP2Win win path x y w h

-----------------------------------------------------------
-- void blitSur(SDL_Surface *src, SDL_Surface *dst);
%foreign frgn "blitSur"
prim_blitSur : Ptr SDL_Surface -> Ptr SDL_Surface -> PrimIO ()

-- | Use this function to perform a fast surface copy to a destination surface.
export
blitSur : HasIO io => Sur -> Sur -> io ()
blitSur (MkSur src) (MkSur dst) = primIO $ prim_blitSur src dst

-----------------------------------------------------------
-- void scaledSur(SDL_Surface *src, SDL_Surface *dst, int x, int y, int w, int h);
%foreign frgn "scaledSur"
prim_scaledSur : Ptr SDL_Surface -> Ptr SDL_Surface -> Int -> Int -> Int -> Int -> PrimIO ()

-- | Performs a scaled surface copy to a destination surface.
export
scaledSur : HasIO io => Sur -> Sur -> Rect -> io ()
scaledSur (MkSur src) (MkSur dst) (MkRect x y w h) = primIO $ prim_scaledSur src dst x y w h

-----------------------------------------------------------
-- void freeSur(SDL_Surface *sur);
%foreign frgn "freeSur"
prim_freeSur : Ptr SDL_Surface -> PrimIO ()

-- | Releases a surface resources.
export
freeSur : HasIO io => Sur -> io ()
freeSur (MkSur sur) = primIO $ prim_freeSur sur
