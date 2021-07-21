{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_render

import IdrisGL.DataType
import IdrisGL.Color

{- FFI -}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_render"

--

%foreign frgn "createRenderer"
prim_createRenderer : AnyPtr -> AnyPtr

||| Create a 2D rendering context for a window.
export
createRenderer : HasIO io => Win -> io Renderer
createRenderer (MkWin win) = pure $ MkRenderer $ prim_createRenderer win

--

%foreign frgn "createTargetTexture"
prim_createTargetTexture : AnyPtr -> AnyPtr -> AnyPtr

||| Create a texture as rendering target.
export
createTargetTexture : HasIO io => Win -> Renderer -> io Texture
createTargetTexture (MkWin win) (MkRenderer ren) 
    = pure $ MkTexture $ prim_createTargetTexture win ren

--

%foreign frgn "setRenderTarget"
prim_setRenderTarget : AnyPtr -> AnyPtr -> PrimIO ()

||| Set a texture as the rendering target.
export
setRenderTarget : HasIO io => Renderer -> Texture -> io ()
setRenderTarget (MkRenderer ren) (MkTexture texture)
    = primIO $ prim_setRenderTarget ren texture

--

%foreign frgn "resetRenderTarget"
prim_resetRenderTarget : AnyPtr -> PrimIO ()

||| Reset a null pointer as the rendering target.
export
resetRenderTarget : HasIO io => Renderer -> io ()
resetRenderTarget (MkRenderer ren)
    = primIO $ prim_resetRenderTarget ren

--

%foreign frgn "setRenderDrawColor"
prim_setRenderDrawColor : AnyPtr
                        -> Int -> Int -> Int -> Int
                        -> PrimIO ()

||| Set the color used for drawing operations (Rect, Line and Clear).
export
setRenderDrawColor : HasIO io => Renderer -> Color -> io ()
setRenderDrawColor (MkRenderer ren) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_setRenderDrawColor ren r g b a

--

%foreign frgn "createTextureFromSur"
prim_createTextureFromSur : AnyPtr -> AnyPtr -> AnyPtr

||| Create a texture from surface.
export
createTextureFromSur : HasIO io => Renderer -> Sur -> io Texture
createTextureFromSur (MkRenderer ren) (MkSur sur) 
    = pure $ MkTexture $ prim_createTextureFromSur ren sur

--

%foreign frgn "renderClear"
prim_renderClear : AnyPtr -> PrimIO ()

||| Clear the rendering target with the drawing color.
export
renderClear : HasIO io => Renderer -> io ()
renderClear (MkRenderer ren)
    = primIO $ prim_renderClear ren

--

%foreign frgn "renderPresent"
prim_renderPresent : AnyPtr -> PrimIO ()

||| Update the screen with any rendering performed since the previous call.
export
renderPresent : HasIO io => Renderer -> io ()
renderPresent (MkRenderer ren)
    = primIO $ prim_renderPresent ren

--

%foreign frgn "renderCopy"
prim_renderCopy : AnyPtr -> AnyPtr
                -> Int -> Int -> Int -> Int
                -> PrimIO ()

||| Copy a portion of the texture to the current rendering target.
export
renderCopy : HasIO io => Renderer -> Texture -> Rect -> io ()
renderCopy (MkRenderer ren) (MkTexture t) (MkRect x y w h)
    = primIO $ prim_renderCopy ren t x y w h

-- 

%foreign frgn "renderCopyEx"
prim_renderCopyEx : AnyPtr -> AnyPtr
                 -> Int -> Int -> Int -> Int
                 -> Double -> Int -> Int -> Int
                 -> PrimIO ()

||| Copy a portion of the texture to the current rendering, with optional rotation and flipping.
||| @ angle An angle in degrees that indicates the rotation in a clockwise direction.
export
renderCopyEx : HasIO io => Renderer -> Texture -> Rect 
                        -> (angle : Double) -> Coordinate -> FlipSetting
                        -> io ()
renderCopyEx (MkRenderer ren) (MkTexture texture) (MkRect x y w h) angle (MkCoor cx cy) flip
    = primIO $ prim_renderCopyEx ren texture x y w h angle cx cy (flip' flip)
    where flip' : FlipSetting -> Int
          flip' FLIP_NONE       = 0
          flip' FLIP_HORIZONTAL = 1
          flip' FLIP_VERTICAL   = 2

--

%foreign frgn "renderCopyExWin"
prim_renderCopyExWin : AnyPtr -> AnyPtr -> AnyPtr
                    -> Double -> Int -> Int -> Int
                    -> PrimIO ()

||| Copy a portion of the texture to the current rendering, with optional rotation and flipping.
||| The difference between it and renderCopyEx is the size has been set to the window size.
||| @ angle An angle in degrees that indicates the rotation in a clockwise direction.
export
renderCopyExWin : HasIO io => Win -> Renderer -> Texture
                           -> (angle : Double) -> Coordinate -> FlipSetting
                           -> io ()
renderCopyExWin (MkWin win) (MkRenderer ren) (MkTexture texture) angle (MkCoor cx cy) flip
    = primIO $ prim_renderCopyExWin win ren texture angle cx cy (flip' flip)
    where flip' : FlipSetting -> Int
          flip' FLIP_NONE       = 0
          flip' FLIP_HORIZONTAL = 1
          flip' FLIP_VERTICAL   = 2

--

%foreign frgn "freeRender"
prim_freeRender : AnyPtr -> PrimIO ()

||| Release sources of a renderer.
export
freeRender : HasIO io => Renderer -> io ()
freeRender (MkRenderer ren)
    = primIO $ prim_freeRender ren

--

%foreign frgn "renderFillRect"
prim_renderFillRect : AnyPtr
                    -> Int -> Int -> Int -> Int
                    -> Int -> Int -> Int -> Int
                    -> PrimIO ()

||| Fill a rectangle on the current rendering target with the drawing color.
export
renderFillRect : HasIO io => Renderer -> Rect -> Color -> io ()
renderFillRect (MkRenderer ren) (MkRect x y w h) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_renderFillRect ren x y w h r g b a

--

%foreign frgn "renderDrawRect"
prim_renderDrawRect : AnyPtr
                    -> Int -> Int -> Int -> Int
                    -> Int -> Int -> Int -> Int
                    -> PrimIO ()

||| Draw a rectangle on the current rendering target.
export
renderDrawRect : HasIO io => Renderer -> Rect -> Color -> io ()
renderDrawRect (MkRenderer ren) (MkRect x y w h) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_renderDrawRect ren x y w h r g b a

--

%foreign frgn "renderDrawLine"
prim_renderDrawLine : AnyPtr
                    -> Int -> Int -> Int -> Int
                    -> Int -> Int -> Int -> Int
                    -> PrimIO ()

||| Draw a line on the current rendering target.
export
renderDrawLine : HasIO io => Renderer -> Coordinate -> Coordinate -> Color -> io ()
renderDrawLine (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_renderDrawLine ren x1 y1 x2 y2 r g b a

-- 

%foreign frgn "renderDrawPoint"
prim_renderDrawPoint : AnyPtr
                     -> Int -> Int
                     -> Int -> Int -> Int -> Int
                     -> PrimIO ()

||| Draw a point on the current rendering target.
export
renderDrawPoint : HasIO io => Renderer -> Coordinate -> Color -> io ()
renderDrawPoint (MkRenderer ren) (MkCoor x y) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_renderDrawPoint ren x y r g b a