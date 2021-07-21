{- Tian Z (ecburx@burx.vip) -}

||| Predefined and custom colors.
module IdrisGL.Color

||| Make a custom color. All components are clamped to the range [0..255].
public export
data Color : Type where
    ||| RGBA color.
    ||| @ r Red component.
    ||| @ g Green component.
    ||| @ b Blue component.
    ||| @ a Alpha component.
    MkRGBA : (r : Int) -> (g : Int) -> (b : Int) -> (a : Int) -> Color
    ||| RGB color.
    ||| @ r Red component.
    ||| @ g Green component.
    ||| @ b Blue component.
    MkRGB  : (r : Int) -> (g : Int) -> (b : Int) -> Color

public export
Eq Color where
    (MkRGBA r1 g1 b1 a1) == (MkRGBA r2 g2 b2 a2) = 
        (r1 == r2) && (g1 == g2) && (b1 == b2) && (a1 == a2)

    (MkRGB  r1 g1 b1)    == (MkRGB  r2 g2 b2) = 
        (r1 == r2) && (g1 == g2) && (b1 == b2)
    
    (MkRGBA r1 g1 b1 a1) == (MkRGB  r2 g2 b2) =
        (r1 == r2) && (g1 == g2) && (b1 == b2) && (a1 == 255)
    
    (MkRGB  r1 g1 b1)    == (MkRGBA r2 g2 b2 a2) = 
        (r1 == r2) && (g1 == g2) && (b1 == b2) && (a2 == 255)

    a /= b = not (a == b)

||| Take the RGBA components of a color.
||| @ color Color.
export
rgbaOfColor : (color : Color) -> (Int,Int,Int,Int)
rgbaOfColor (MkRGB  r g b)   = (r,g,b,255)
rgbaOfColor (MkRGBA r g b a) = (r,g,b,a)

||| Add RGB components of a color component-wise, then normalise them to the highest resulting one. 
||| The alpha components are averaged.
||| @ c1 First color.
||| @ c2 Second color.
export
addColors : (c1 : Color) -> (c2 : Color) -> Color
addColors c1 c2 =
    let (r1, g1, b1, a1) = rgbaOfColor c1
        (r2, g2, b2, a2) = rgbaOfColor c2
    in  MkRGBA (r1 + r2) (g1 + g2) (b1 + b2) ((a1 + a2) `div` 2)

{- Predifined colors. -}

export
transparent : Color
transparent = MkRGBA 0 0 0 0

export
white   : Color
white   = MkRGB 255 255 255

export
black   : Color
black   = MkRGB   0   0   0

export
red     : Color
red     = MkRGB 255   0   0

export
green   : Color
green   = MkRGB   0 255   0

export
blue    : Color
blue    = MkRGB   0   0 255

export
yellow  : Color
yellow  = MkRGB 255 255   0

export
magenta : Color
magenta = MkRGB 255   0 255

export
cyan    : Color
cyan    = MkRGB   0 255 255