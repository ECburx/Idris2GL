{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.DataType

{- Types -}

public export
data Rect : Type where
    MkRect : Int -> Int -> Int -> Int -> Rect

public export
data Color : Type where
    MkColor : Int -> Int -> Int -> Int -> Color

public export
data Coordinate : Type where
    MkCoor : Int -> Int -> Coordinate

{- Pinter Types -}

-- | SDL_Surface pointer Type.
public export
data Sur : Type where
    MkSur : AnyPtr -> Sur

-- | SDL_Window pointer Type.
public export
data Win : Type where
    MkWin : AnyPtr -> Win

public export
data Renderer : Type where
    MkRenderer : AnyPtr -> Renderer

public export
data Texture : Type where
    MkTexture : AnyPtr -> Texture

{- Datas -}

public export
data Display
    --         title  size
    = InWindow String Rect
    | FullWindow

public export
data Picture
    = Blank
    --              Path   Size
    | Image         String Rect
    | Bitmap        String Rect
    --              Start      End              Thickness
    | Pixel         Coordinate            Color
    | ThickLine     Coordinate Coordinate Color Int
    | Line          Coordinate Coordinate Color
    --                         Fill Radius
    | Rectangle     Rect Color Bool
    | R_Rectangle   Rect Color Bool Int
    --              Center           Fill Radius
    | Circle        Coordinate Color Bool Int
    -- Start : Starting radius in degrees of the arc. 0 degrees is down, increasing counterclockwise.
    -- End   :   Ending radius in degrees of the arc. 0 degrees is down, increasing counterclockwise. 
    --              Center           Radius Start End
    | Arc           Coordinate Color Int    Int   Int
    | Pie           Coordinate Color Int    Int   Int
    --              Center     Horizontal radius Vertical radius       Fill
    | Ellipse       Coordinate Int               Int             Color Bool
    --                                                     Fill
    | Trigon        Coordinate Coordinate Coordinate Color Bool
    --                                      Size
    -- | Character     Char   Coordinate Color Int
    -- | StringPic     String Coordinate Color Int
    | Pictures      (List Picture)