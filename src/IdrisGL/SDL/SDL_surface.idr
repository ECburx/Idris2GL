{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_surface

import IdrisGL.DataType

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_surface"

--

%foreign frgn "blitSur"
prim_blitSur : AnyPtr -> AnyPtr -> PrimIO ()

||| Use this function to perform a fast surface copy to a destination surface.
export
blitSur : HasIO io => Sur -> Sur -> io ()
blitSur (MkSur src) (MkSur dst) = primIO $ prim_blitSur src dst

--

%foreign frgn "scaledSur"
prim_scaledSur : AnyPtr -> AnyPtr -> Int -> Int -> Int -> Int -> PrimIO ()

||| Use this function to perform a scaled surface copy to a destination surface.
export
scaledSur : HasIO io => Sur -> Sur -> Rect -> io ()
scaledSur (MkSur src) (MkSur dst) (MkRect x y w h) = primIO $ prim_scaledSur src dst x y w h

--

%foreign frgn "freeSur"
prim_freeSur : AnyPtr -> PrimIO ()

||| Release resource of a surface.
export
freeSur : HasIO io => Sur -> io ()
freeSur (MkSur sur) = primIO $ prim_freeSur sur

