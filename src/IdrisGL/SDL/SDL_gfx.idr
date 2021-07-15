{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_gfx

import IdrisGL.DataType

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_gfx"

-- Pixel

%foreign frgn "pixel"
prim_pixel : AnyPtr 
           -> Int -> Int 
           -> Int -> Int -> Int -> Int 
           -> PrimIO ()

export
pixel : HasIO io => Renderer -> Coordinate -> Color -> io ()
pixel (MkRenderer ren) (MkCoor x y) (MkColor r g b a)
    = primIO $ prim_pixel ren x y r g b a

-- Line

%foreign frgn "thickLine"
prim_thickLine : AnyPtr
          -> Int -> Int -> Int -> Int
          -> Int -> Int -> Int -> Int
          -> Int
          -> PrimIO ()

export
thickLine : HasIO io => Renderer -> Coordinate -> Coordinate -> Color -> Int -> io ()
thickLine (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) (MkColor r g b a) width
    = primIO $ prim_thickLine ren x1 y1 x2 y2 r g b a width

--

%foreign frgn "aaline"
prim_aaline : AnyPtr
          -> Int -> Int -> Int -> Int
          -> Int -> Int -> Int -> Int
          -> PrimIO ()

export
aaline : HasIO io => Renderer -> Coordinate -> Coordinate -> Color -> io ()
aaline (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) (MkColor r g b a)
    = primIO $ prim_aaline ren x1 y1 x2 y2 r g b a

-- Rectangle

%foreign frgn "rect"
prim_rect : AnyPtr
          -> Int -> Int -> Int -> Int
          -> Int -> Int -> Int -> Int
          -> PrimIO ()

export
rectangle : HasIO io => Renderer -> Rect -> Color -> io ()
rectangle (MkRenderer ren) (MkRect x y w h) (MkColor r g b a)
    = primIO $ prim_rect ren x y w h r g b a

-- 

%foreign frgn "roundedRect"
prim_roundedRect : AnyPtr 
                 -> Int -> Int -> Int -> Int
                 -> Int -> Int -> Int -> Int
                 -> Int
                 -> PrimIO ()

export
roundedRect : HasIO io => Renderer -> Rect -> Color -> Int -> io ()
roundedRect (MkRenderer ren) (MkRect x y w h) (MkColor r g b a) rad
    = primIO $ prim_roundedRect ren x y w h r g b a rad

--

%foreign frgn "filledRect"
prim_filledRect : AnyPtr 
                -> Int -> Int -> Int -> Int
                -> Int -> Int -> Int -> Int
                -> PrimIO ()
export
filledRect : HasIO io => Renderer -> Rect -> Color -> io ()
filledRect (MkRenderer ren) (MkRect x y w h) (MkColor r g b a)
    = primIO $ prim_filledRect ren x y w h r g b a

-- 

%foreign frgn "roundedFilledRect"
prim_roundedFilledRect : AnyPtr
                       -> Int -> Int -> Int -> Int
                       -> Int -> Int -> Int -> Int
                       -> Int
                       -> PrimIO ()

export
roundedFilledRect : HasIO io => Renderer -> Rect -> Color -> Int -> io ()
roundedFilledRect (MkRenderer ren) (MkRect x y w h) (MkColor r g b a) rad
    = primIO $ prim_roundedFilledRect ren x y w h r g b a rad

-- Circle

%foreign frgn "circle"
prim_circle : AnyPtr
            -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> Int
            -> PrimIO ()

export
circle : HasIO io => Renderer -> Coordinate -> Color -> Int -> io ()
circle (MkRenderer ren) (MkCoor x y) (MkColor r g b a) rad
    = primIO $ prim_circle ren x y r g b a rad

--

%foreign frgn "aaCircle"
prim_aaCircle : AnyPtr
            -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> Int
            -> PrimIO ()

export
aaCircle : HasIO io => Renderer -> Coordinate -> Color -> Int -> io ()
aaCircle (MkRenderer ren) (MkCoor x y) (MkColor r g b a) rad
    = primIO $ prim_aaCircle ren x y r g b a rad

--

%foreign frgn "filledCircle"
prim_filledCircle : AnyPtr
            -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> Int
            -> PrimIO ()

export
filledCircle : HasIO io => Renderer -> Coordinate -> Color -> Int -> io ()
filledCircle (MkRenderer ren) (MkCoor x y) (MkColor r g b a) rad
    = primIO $ prim_filledCircle ren x y r g b a rad

--

%foreign frgn "thickCircle"
prim_thickCircle : AnyPtr
                -> Int -> Int
                -> Int -> Int -> Int -> Int
                -> Int -> Int
                -> PrimIO ()

export
thickCircle : HasIO io => Renderer -> Coordinate -> Color -> Int -> Int -> io ()
thickCircle (MkRenderer ren) (MkCoor x y) (MkColor r g b a) rad width
    = primIO $ prim_thickCircle ren x y r g b a rad width

-- Arc

%foreign frgn "arc"
prim_arc : AnyPtr
         -> Int -> Int
         -> Int -> Int -> Int -> Int
         -> Int -> Int -> Int
         -> PrimIO ()

export
arc : HasIO io => Renderer -> Coordinate -> Color -> Int -> Int -> Int -> io ()
arc (MkRenderer ren) (MkCoor x y) (MkColor r g b a) rad start end
    = primIO $ prim_arc ren x y r g b a rad start end

-- Ellipse

%foreign frgn "ellipse"
prim_ellipse : AnyPtr
             -> Int -> Int -> Int -> Int
             -> Int -> Int -> Int -> Int
             -> PrimIO ()
export
ellipse : HasIO io => Renderer -> Coordinate -> Int -> Int -> Color -> io ()
ellipse (MkRenderer ren) (MkCoor x y) rx ry (MkColor r g b a)
    = primIO $ prim_ellipse ren x y rx ry r g b a

--

%foreign frgn "filledEllipse"
prim_filledEllipse : AnyPtr
             -> Int -> Int -> Int -> Int
             -> Int -> Int -> Int -> Int
             -> PrimIO ()
export
filledEllipse : HasIO io => Renderer -> Coordinate -> Int -> Int -> Color -> io ()
filledEllipse (MkRenderer ren) (MkCoor x y) rx ry (MkColor r g b a)
    = primIO $ prim_filledEllipse ren x y rx ry r g b a

--

%foreign frgn "aaellipse"
prim_aaellipse : AnyPtr
             -> Int -> Int -> Int -> Int
             -> Int -> Int -> Int -> Int
             -> PrimIO ()
export
aaellipse : HasIO io => Renderer -> Coordinate -> Int -> Int -> Color -> io ()
aaellipse (MkRenderer ren) (MkCoor x y) rx ry (MkColor r g b a)
    = primIO $ prim_aaellipse ren x y rx ry r g b a

-- Pie

%foreign frgn "pie"
prim_pie : AnyPtr
         -> Int -> Int
         -> Int -> Int -> Int -> Int
         -> Int -> Int -> Int
         -> PrimIO ()

export
pie : HasIO io => Renderer -> Coordinate -> Color -> Int -> Int -> Int -> io ()
pie (MkRenderer ren) (MkCoor x y) (MkColor r g b a) rad start end
    = primIO $ prim_pie ren x y r g b a rad start end

-- Trigon

%foreign frgn "trigon"
prim_trigon : AnyPtr
            -> Int -> Int -> Int -> Int -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> PrimIO ()

export
trigon : HasIO io => Renderer -> Coordinate -> Coordinate -> Coordinate -> Color -> io ()
trigon (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) (MkCoor x3 y3) (MkColor r g b a)
    = primIO $ prim_trigon ren x1 y1 x2 y2 x3 y3 r g b a

--

%foreign frgn "filledTrigon"
prim_filledTrigon : AnyPtr
            -> Int -> Int -> Int -> Int -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> PrimIO ()

export
filledTrigon : HasIO io => Renderer -> Coordinate -> Coordinate -> Coordinate -> Color -> io ()
filledTrigon (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) (MkCoor x3 y3) (MkColor r g b a)
    = primIO $ prim_filledTrigon ren x1 y1 x2 y2 x3 y3 r g b a

--

%foreign frgn "aatrigon"
prim_aatrigon : AnyPtr
            -> Int -> Int -> Int -> Int -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> PrimIO ()

export
aatrigon : HasIO io => Renderer -> Coordinate -> Coordinate -> Coordinate -> Color -> io ()
aatrigon (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) (MkCoor x3 y3) (MkColor r g b a)
    = primIO $ prim_aatrigon ren x1 y1 x2 y2 x3 y3 r g b a