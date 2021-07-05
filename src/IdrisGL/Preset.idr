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
-- void qLoadBMP(const char *path, int x, int y, int w, int h);
%foreign frgn "qLoadBMP"
prim_qLoadBMP : String -> Int -> Int -> Int -> Int -> PrimIO ()

-- | Loads, scales and shows a BMP file in one window.
export
qLoadBMP : HasIO io => String -> Rect -> io ()
qLoadBMP path (MkRect x y w h) = primIO $ prim_qLoadBMP path x y w h

-----------------------------------------------------------
-- void qLoadIMG(const char *path, int x, int y, int w, int h);
%foreign frgn "qLoadIMG"
prim_qLoadIMG : String -> Int -> Int -> Int -> Int -> PrimIO ()

-- | Loads, scales and shows an image in one window.
export
qLoadIMG : HasIO io => String -> Rect -> io ()
qLoadIMG path (MkRect x y w h) = primIO $ prim_qLoadIMG path x y w h