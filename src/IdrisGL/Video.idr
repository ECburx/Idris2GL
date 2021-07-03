{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Video

import IdrisGL.SDLtypes
import IdrisGL.SDL_Support.SDL_sysvideo
import IdrisGL.SDL_Support.SDL_surface

frgn : String -> String
frgn func = "C:" ++ func ++ ",video"

-- +---------------+
-- | FFI functions |
-- +---------------+

-----------------------------------------------------------
-- | SDL_Window *createWin(const char *title, int x, int y, int w, int h, int flags);
%foreign frgn "createWin"
prim_createWin : String -> Int -> Int -> Int -> Int -> Int -> Ptr SDL_Window

-- | Initializes the SDL library and creates a window with the specified position, dimensions, and flags.
export
createWin : HasIO io => String -> Int -> Int -> Int -> Int -> Int -> io Win
createWin title x y w h flags = pure $ MkWin $ prim_createWin title x y w h flags

-----------------------------------------------------------
-- | void closeWin(SDL_Window *win);
%foreign frgn "closeWin"
prim_closeWin : Ptr SDL_Window -> PrimIO ()

-- | Destroy a window.
export
closeWin : HasIO io => Win -> io ()
closeWin (MkWin wptr) = primIO $ prim_closeWin wptr

-----------------------------------------------------------
-- | SDL_Surface *getWinSur(SDL_Window *win);
%foreign frgn "getWinSur"
prim_getWinSur : Ptr SDL_Window -> Ptr SDL_Surface

-- | Get the SDL surface associated with the window.
export
getWinSur : HasIO io => Win -> io Sur
getWinSur (MkWin wptr) = pure $ MkSur $ prim_getWinSur wptr

-----------------------------------------------------------
-- | void updateWinSur(SDL_Window *win);
%foreign frgn "updateWinSur"
prim_updateWinSur : Ptr SDL_Window -> PrimIO ()

export
updateWinSur : HasIO io => Win -> io ()
updateWinSur (MkWin wptr) = primIO $ prim_updateWinSur wptr