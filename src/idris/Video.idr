-- Window.idr
-- Tian Z 2021/7/1

module Video

import SDL_Support.SDL_sysvideo

frgn : String -> String -> String
frgn func sourceFile = "C:" ++ func ++ ",video"

-- | SDL_Window pointer Type.
data Win : Type where
     MkWin : Ptr SDL_Window -> Win

-- +---------------+
-- | FFI functions |
-- +---------------+

-- | FFI % display.createWin()
-- | SDL_Window *createWin(const char *title, int x, int y, int w, int h, int flags);
%foreign frgn "createWin" "video"
prim_createWin : String -> Int -> Int -> Int -> Int -> Int -> Ptr SDL_Window

-- | Initializes the SDL library and creates a window with the specified position, dimensions, and flags.
export
createWin : HasIO io => String -> Int -> Int -> Int -> Int -> Int -> io Win
createWin title x y w h flags = pure $ MkWin $ prim_createWin title x y w h flags

-- | FFI % display.delayWin()
-- -- | void delayWin(int ms);
-- %foreign frgn "delayWin" "timer"
-- prim_delayWin : Int -> PrimIO ()

-- -- | Wait a specified number of milliseconds before returning.
-- delayWin : HasIO io => Int -> io ()
-- delayWin ms = primIO $ prim_delayWin ms

-- | FFI % display.closeWin()
-- | void closeWin(SDL_Window *win);
%foreign frgn "closeWin" "video"
prim_closeWin : Ptr SDL_Window -> PrimIO ()

export
closeWin : HasIO io => Win -> io ()
closeWin (MkWin wptr) = primIO $ prim_closeWin wptr