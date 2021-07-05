{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Image

import IdrisGL.SDLtypes
import IdrisGL.SDL_Support.SDL_surface
import IdrisGL.SDL_Support.SDL_rect
import IdrisGL.SDL_Support.SDL_sysvideo

frgn : String -> String
frgn func = "C:" ++ func ++ ",image"

-- +---------------+
-- | FFI functions |
-- +---------------+

-----------------------------------------------------------
-- SDL_Surface *loadIMGSur(char *path);
%foreign frgn "loadIMGSur"
prim_loadIMGSur : String -> Ptr SDL_Surface

-- | Use this function to load a surface from an image.
export
loadIMGSur : HasIO io => String -> io Sur
loadIMGSur path = pure $ MkSur $ prim_loadIMGSur path

-----------------------------------------------------------
-- void loadIMG2Win(SDL_Window *win, char *path, int x, int y, int w, int h);
%foreign frgn "loadIMG2Win"
prim_loadIMG2Win : Ptr SDL_Window -> String -> Int -> Int -> Int -> Int -> PrimIO ()

-- | Loads and shows an image in a window.
export
loadIMG2Win : HasIO io => Win -> String -> Rect -> io ()
loadIMG2Win (MkWin win) path (MkRect x y w h) = primIO $ prim_loadIMG2Win win path x y w h