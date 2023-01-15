{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_gfx

import IdrisGL.DataType
import IdrisGL.Color

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

||| Draw a pixel.
export
pixel : HasIO io => Renderer -> Coordinate -> Color -> io ()
pixel (MkRenderer ren) (MkCoor x y) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_pixel ren x y r g b a

-- Line

%foreign frgn "thickLine"
prim_thickLine : AnyPtr
          -> Int -> Int -> Int -> Int
          -> Int -> Int -> Int -> Int
          -> Int
          -> PrimIO ()

||| Draw a line with given thickness.
||| @ width Thickness.
export
thickLine : HasIO io => Renderer
                     -> Coordinate -> Coordinate -> Color
                     -> (width : Int)
                     -> io ()
thickLine (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) color width
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_thickLine ren x1 y1 x2 y2 r g b a width

--

%foreign frgn "aaline"
prim_aaline : AnyPtr
          -> Int -> Int -> Int -> Int
          -> Int -> Int -> Int -> Int
          -> PrimIO ()

||| Draw an anti-aliased line.
export
aaline : HasIO io => Renderer -> Coordinate -> Coordinate -> Color -> io ()
aaline (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_aaline ren x1 y1 x2 y2 r g b a

-- Rectangle

%foreign frgn "rect"
prim_rect : AnyPtr
          -> Int -> Int -> Int -> Int
          -> Int -> Int -> Int -> Int
          -> PrimIO ()

||| Draw a rectangle.
export
rectangle : HasIO io => Renderer -> Rect -> Color -> io ()
rectangle (MkRenderer ren) (MkRect x y w h) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_rect ren x y w h r g b a

--

%foreign frgn "roundedRect"
prim_roundedRect : AnyPtr
                 -> Int -> Int -> Int -> Int
                 -> Int -> Int -> Int -> Int
                 -> Int
                 -> PrimIO ()

||| Draw a rounded-corner rectangle.
||| @ rad The radius of the corner arc.
export
roundedRect : HasIO io => Renderer -> Rect -> Color -> (rad : Int) -> io ()
roundedRect (MkRenderer ren) (MkRect x y w h) color rad
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_roundedRect ren x y w h r g b a rad

--

%foreign frgn "filledRect"
prim_filledRect : AnyPtr
                -> Int -> Int -> Int -> Int
                -> Int -> Int -> Int -> Int
                -> PrimIO ()

||| Draw a rectangle filled with the given color.
export
filledRect : HasIO io => Renderer -> Rect -> Color -> io ()
filledRect (MkRenderer ren) (MkRect x y w h) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_filledRect ren x y w h r g b a

--

%foreign frgn "roundedFilledRect"
prim_roundedFilledRect : AnyPtr
                       -> Int -> Int -> Int -> Int
                       -> Int -> Int -> Int -> Int
                       -> Int
                       -> PrimIO ()

||| Draw a rounded-corner rectangle filled with the given color.
||| @ rad The radius of the corner arc.
export
roundedFilledRect : HasIO io => Renderer -> Rect -> Color -> (rad : Int) -> io ()
roundedFilledRect (MkRenderer ren) (MkRect x y w h) color rad
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_roundedFilledRect ren x y w h r g b a rad

-- Circle

%foreign frgn "circle"
prim_circle : AnyPtr
            -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> Int
            -> PrimIO ()

||| Draw a circle.
||| @ rad	Radius in pixels of the circle.
export
circle : HasIO io => Renderer -> Coordinate -> Color -> (rad : Int) -> io ()
circle (MkRenderer ren) (MkCoor x y) color rad
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_circle ren x y r g b a rad

--

%foreign frgn "aaCircle"
prim_aaCircle : AnyPtr
            -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> Int
            -> PrimIO ()

||| Draw an anti-aliased circle.
||| @ rad	Radius in pixels of the circle.
export
aaCircle : HasIO io => Renderer -> Coordinate -> Color -> Int -> io ()
aaCircle (MkRenderer ren) (MkCoor x y) color rad
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_aaCircle ren x y r g b a rad

--

%foreign frgn "filledCircle"
prim_filledCircle : AnyPtr
            -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> Int
            -> PrimIO ()

||| Draw a circle filled with given color.
||| @ rad	Radius in pixels of the circle.
export
filledCircle : HasIO io => Renderer -> Coordinate -> Color -> Int -> io ()
filledCircle (MkRenderer ren) (MkCoor x y) color rad
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_filledCircle ren x y r g b a rad

--

%foreign frgn "thickCircle"
prim_thickCircle : AnyPtr
                -> Int -> Int
                -> Int -> Int -> Int -> Int
                -> Int -> Int
                -> PrimIO ()

||| Draw a circle with the given radius and thickness.
||| @ rad	  Radius in pixels of the circle.
||| @ width Thickness.
export
thickCircle : HasIO io => Renderer -> Coordinate -> Color -> (rad : Int) -> (width : Int) -> io ()
thickCircle (MkRenderer ren) (MkCoor x y) color rad width
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_thickCircle ren x y r g b a rad width

-- Arc

%foreign frgn "arc"
prim_arc : AnyPtr
         -> Int -> Int
         -> Int -> Int -> Int -> Int
         -> Int -> Int -> Int
         -> PrimIO ()

||| Draw a circular arc drawn counter-clockwise between two angles (in degrees).
||| @ rad	  Radius in pixels of the circle.
||| @ start The angle of start point.
||| @ end   The angle of end point.
export
arc : HasIO io => Renderer
               -> Coordinate -> Color
               -> (rad : Int) -> (start : Int) -> (end : Int)
               -> io ()
arc (MkRenderer ren) (MkCoor x y) color rad start end
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_arc ren x y r g b a rad start end

-- Ellipse

%foreign frgn "ellipse"
prim_ellipse : AnyPtr
             -> Int -> Int -> Int -> Int
             -> Int -> Int -> Int -> Int
             -> PrimIO ()

||| Draw an ellipse.
||| @ rx Horizontal radius in pixels of the ellipse.
||| @ ry Vertical radius in pixels of the ellipse.
export
ellipse : HasIO io => Renderer -> Coordinate
                   -> (rx : Int) -> (ry : Int) -> Color
                   -> io ()
ellipse (MkRenderer ren) (MkCoor x y) rx ry color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_ellipse ren x y rx ry r g b a

--

%foreign frgn "filledEllipse"
prim_filledEllipse : AnyPtr
             -> Int -> Int -> Int -> Int
             -> Int -> Int -> Int -> Int
             -> PrimIO ()

||| Draw an ellipse filled with given color.
||| @ rx Horizontal radius in pixels of the ellipse.
||| @ ry Vertical radius in pixels of the ellipse.
export
filledEllipse : HasIO io => Renderer -> Coordinate
                   -> (rx : Int) -> (ry : Int) -> Color
                   -> io ()
filledEllipse (MkRenderer ren) (MkCoor x y) rx ry color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_filledEllipse ren x y rx ry r g b a

--

%foreign frgn "aaellipse"
prim_aaellipse : AnyPtr
             -> Int -> Int -> Int -> Int
             -> Int -> Int -> Int -> Int
             -> PrimIO ()

||| Draw an anti-aliased ellipse.
||| @ rx Horizontal radius in pixels of the ellipse.
||| @ ry Vertical radius in pixels of the ellipse.
export
aaellipse : HasIO io => Renderer -> Coordinate
                     -> (rx : Int) -> (ry : Int) -> Color
                     -> io ()
aaellipse (MkRenderer ren) (MkCoor x y) rx ry color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_aaellipse ren x y rx ry r g b a

-- Pie

%foreign frgn "pie"
prim_pie : AnyPtr
         -> Int -> Int
         -> Int -> Int -> Int -> Int
         -> Int -> Int -> Int
         -> PrimIO ()

%foreign frgn "filledPie"
prim_filledPie : AnyPtr
         -> Int -> Int
         -> Int -> Int -> Int -> Int
         -> Int -> Int -> Int
         -> PrimIO ()

||| Draw a pie.
||| @ rad	  Radius in pixels of the circle.
||| @ start The angle of start point.
||| @ end   The angle of end point.
export
pie : HasIO io => Renderer -> Coordinate -> Color
               -> (rad : Int) -> (start : Int) -> (end : Int)
               -> io ()
pie (MkRenderer ren) (MkCoor x y) color rad start end
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_pie ren x y r g b a rad start end

||| Draw a filled pie.
||| @ rad	  Radius in pixels of the circle.
||| @ start The angle of start point.
||| @ end   The angle of end point.
export
filledPie : HasIO io => Renderer -> Coordinate -> Color
               -> (rad : Int) -> (start : Int) -> (end : Int)
               -> io ()
filledPie (MkRenderer ren) (MkCoor x y) color rad start end
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_filledPie ren x y r g b a rad start end


-- Trigon

%foreign frgn "trigon"
prim_trigon : AnyPtr
            -> Int -> Int -> Int -> Int -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> PrimIO ()

||| Draw a trigon.
export
trigon : HasIO io => Renderer -> Coordinate -> Coordinate -> Coordinate -> Color -> io ()
trigon (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) (MkCoor x3 y3) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_trigon ren x1 y1 x2 y2 x3 y3 r g b a

--

%foreign frgn "filledTrigon"
prim_filledTrigon : AnyPtr
            -> Int -> Int -> Int -> Int -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> PrimIO ()

||| Draw a trigon filled with given color.
export
filledTrigon : HasIO io => Renderer -> Coordinate -> Coordinate -> Coordinate -> Color -> io ()
filledTrigon (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) (MkCoor x3 y3) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_filledTrigon ren x1 y1 x2 y2 x3 y3 r g b a

--

%foreign frgn "aatrigon"
prim_aatrigon : AnyPtr
            -> Int -> Int -> Int -> Int -> Int -> Int
            -> Int -> Int -> Int -> Int
            -> PrimIO ()

||| Draw an anti-aliased trigon.
export
aatrigon : HasIO io => Renderer -> Coordinate -> Coordinate -> Coordinate -> Color -> io ()
aatrigon (MkRenderer ren) (MkCoor x1 y1) (MkCoor x2 y2) (MkCoor x3 y3) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_aatrigon ren x1 y1 x2 y2 x3 y3 r g b a
