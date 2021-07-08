{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_image

import IdrisGL.DataType

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_image"

--

%foreign frgn "loadIMGSur"
prim_loadIMGSur : String -> AnyPtr

export
loadIMGSur : HasIO io => String -> io Sur
loadIMGSur path = pure $ MkSur $ prim_loadIMGSur path
