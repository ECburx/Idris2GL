-- Window.idr
-- Tian Z 2021/7/1

module Window

import SDL_Support.SDL_sysvideo

-- | Generates %foreign string.
frgn : String -> String
frgn f = "C:" ++ f ++ ",display"

-- | SDL_Window pointer Type.
data Win : Type where
     MkWin : Ptr SDL_Window -> Win

-- +---------------+
-- | FFI functions |
-- +---------------+

-- | FFI % display.createWin()
-- | SDL_Window *createWin(const char *title, int x, int y, int w, int h, int flags);
%foreign frgn "createWin"
prim_createWin : String -> Int -> Int -> Int -> Int -> Int -> Ptr SDL_Window

-- | Initializes the SDL library and creates a window with the specified position, dimensions, and flags.
createWin : HasIO io => String -> Int -> Int -> Int -> Int -> Int -> io Win
createWin title x y w h flags = pure $ MkWin $ prim_createWin title x y w h flags

-- | FFI % display.delayWin()
-- | void delayWin(int ms);
%foreign frgn "delayWin"
prim_delayWin : Int -> PrimIO ()

-- | Wait a specified number of milliseconds before returning.
delayWin : HasIO io => Int -> io ()
delayWin ms = primIO $ prim_delayWin ms

-- | FFI % display.closeWin()
-- | void closeWin(SDL_Window *win);
%foreign frgn "closeWin"
prim_closeWin : Ptr SDL_Window -> PrimIO ()

closeWin : HasIO io => Win -> io ()
closeWin (MkWin wptr) = primIO $ prim_closeWin wptr

-- quit tests. TODO: Delete.
main : IO()
main = do win <- createWin "pig" 300 400 300 400 0
          delayWin 2000
          closeWin win
          pure ()