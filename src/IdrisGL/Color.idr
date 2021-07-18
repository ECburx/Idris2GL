{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.Color

public export
data Color : Type where
    MkColor : Int -> Int -> Int -> Int -> Color

public export
Eq Color where
    (MkColor r1 g1 b1 a1) == (MkColor r2 g2 b2 a2) = 
        (r1 == r2) && (g1 == g2) && (b1 == b2) && (a1 == a2)
    a /= b = not (a == b)

public export
transparent : Color
transparent = MkColor 0 0 0 0

public export
white   : Color
white   = MkColor 255 255 255 255

public export
black   : Color
black   = MkColor   0   0   0 255

public export
red     : Color
red     = MkColor 255   0   0 255

public export
green   : Color
green   = MkColor   0 255   0 255

public export
blue    : Color
blue    = MkColor   0   0 255 255

public export
yellow  : Color
yellow  = MkColor 255 255   0 255

public export
magenta : Color
magenta = MkColor 255   0 255 255

public export
cyan    : Color
cyan    = MkColor   0 255 255 255