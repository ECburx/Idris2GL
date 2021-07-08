{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_ttf

import IdrisGL.DataType

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_ttf"

--

%foreign frgn "drawText"
prim_drawText : AnyPtr 
              -> String -> Int -> String
              -> Int -> Int
              -> Int -> Int -> Int -> Int
              -> PrimIO ()

export
drawText : HasIO io => Renderer
                    -> String -> Int -> String
                    -> Coordinate -> Color
                    -> io ()
drawText (MkRenderer ren) text size font (MkCoor x y) (MkColor r g b a) 
    = primIO $ prim_drawText ren text size font x y r g b a