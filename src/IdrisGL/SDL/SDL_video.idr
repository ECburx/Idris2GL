{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_video

import IdrisGL.DataType

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_video"

--

%foreign frgn "createWin"
prim_createWin : String 
               -> Int -> Int -> Int -> Int  -- x y w h
               -> Int                       -- is fullscreen?
               -> AnyPtr

||| Create a window.
export
createWin : HasIO io => Display -> io Win
createWin (InWindow title (MkRect x y w h))
    = pure $ MkWin $ prim_createWin title x y w h 0
createWin FullWindow
    = pure $ MkWin $ prim_createWin ""    0 0 0 0 1

--

%foreign frgn "closeWin"
prim_closeWin : AnyPtr -> PrimIO ()

||| Close an opended window.
export
closeWin : HasIO io => Win -> io ()
closeWin (MkWin wptr) = primIO $ prim_closeWin wptr

--

%foreign frgn "getWinSur"
prim_getWinSur : AnyPtr -> AnyPtr

||| Get surface of a window.
export
getWinSur : HasIO io => Win -> io Sur
getWinSur (MkWin wptr) = pure $ MkSur $ prim_getWinSur wptr

--

%foreign frgn "updateWinSur"
prim_updateWinSur : AnyPtr -> PrimIO ()

||| Update a surface of window.
export
updateWinSur : HasIO io => Win -> io ()
updateWinSur (MkWin wptr) = primIO $ prim_updateWinSur wptr