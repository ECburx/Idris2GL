{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_render

import IdrisGL.DataType

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_render"

--

%foreign frgn "createRenderer"
prim_createRenderer : AnyPtr -> AnyPtr

export
createRenderer : HasIO io => Win -> io Renderer
createRenderer (MkWin win) = pure $ MkRenderer $ prim_createRenderer win

--

%foreign frgn "setRenderDrawColor"
prim_setRenderDrawColor : AnyPtr
                        -> Int -> Int -> Int -> Int
                        -> PrimIO ()

export
setRenderDrawColor : HasIO io => Renderer -> Color -> io ()
setRenderDrawColor (MkRenderer ren) (MkColor r g b a)
    = primIO $ prim_setRenderDrawColor ren r g b a

--

%foreign frgn "createTextureFromSur"
prim_createTextureFromSur : AnyPtr -> AnyPtr -> AnyPtr

export
createTextureFromSur : HasIO io => Renderer -> Sur -> io Texture
createTextureFromSur (MkRenderer ren) (MkSur sur) 
    = pure $ MkTexture $ prim_createTextureFromSur ren sur

--

%foreign frgn "renderClear"
prim_renderClear : AnyPtr -> PrimIO ()

export
renderClear : HasIO io => Renderer -> io ()
renderClear (MkRenderer ren)
    = primIO $ prim_renderClear ren

--

%foreign frgn "renderPresent"
prim_renderPresent : AnyPtr -> PrimIO ()

export
renderPresent : HasIO io => Renderer -> io ()
renderPresent (MkRenderer ren)
    = primIO $ prim_renderPresent ren

--

%foreign frgn "renderCopy"
prim_renderCopy : AnyPtr -> AnyPtr
                -> Int -> Int -> Int -> Int
                -> PrimIO ()

export
renderCopy : HasIO io => Renderer -> Texture -> Rect -> io ()
renderCopy (MkRenderer ren) (MkTexture t) (MkRect x y w h)
    = primIO $ prim_renderCopy ren t x y w h

-- 

%foreign frgn "freeRender"
prim_freeRender : AnyPtr -> PrimIO ()

export
freeRender : HasIO io => Renderer -> io ()
freeRender (MkRenderer ren)
    = primIO $ prim_freeRender ren