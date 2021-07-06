{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_surface

import IdrisGL.DataType

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_surface"

--

%foreign frgn "loadBMPSur"
prim_loadBMPSur : String -> AnyPtr

export
loadBMPSur : HasIO io => String -> io Sur
loadBMPSur path = pure $ MkSur $ prim_loadBMPSur path

--

%foreign frgn "blitSur"
prim_blitSur : AnyPtr -> AnyPtr -> PrimIO ()

export
blitSur : HasIO io => Sur -> Sur -> io ()
blitSur (MkSur src) (MkSur dst) = primIO $ prim_blitSur src dst

--

%foreign frgn "scaledSur"
prim_scaledSur : AnyPtr -> AnyPtr -> Int -> Int -> Int -> Int -> PrimIO ()

export
scaledSur : HasIO io => Sur -> Sur -> Rect -> io ()
scaledSur (MkSur src) (MkSur dst) (MkRect x y w h) = primIO $ prim_scaledSur src dst x y w h

--

%foreign frgn "freeSur"
prim_freeSur : AnyPtr -> PrimIO ()

export
freeSur : HasIO io => Sur -> io ()
freeSur (MkSur sur) = primIO $ prim_freeSur sur
