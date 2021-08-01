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

||| Take the RGBA components of a color.
||| @ color Color.
export
rgbaOfColor : (color : Color) -> (Int,Int,Int,Int)
rgbaOfColor (MkRGB  r g b)   = (r,g,b,255)
rgbaOfColor (MkRGBA r g b a) = (r,g,b,a)

public export
Eq Color where
    a == b = rgbaOfColor a == rgbaOfColor b
    a /= b = not (a == b)
    
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

{- Predefined colors. -}

export partial
transparent : Color
transparent = MkRGBA 0 0 0 0

export partial
white   : Color
white   = MkRGB 255 255 255

export partial
black   : Color
black   = MkRGB   0   0   0

export partial
red     : Color
red     = MkRGB 255   0   0

export partial
green   : Color
green   = MkRGB   0 255   0

export partial
blue    : Color
blue    = MkRGB   0   0 255

export partial
yellow  : Color
yellow  = MkRGB 255 255   0

export partial
magenta : Color
magenta = MkRGB 255   0 255

export partial
cyan    : Color
cyan    = MkRGB   0 255 255