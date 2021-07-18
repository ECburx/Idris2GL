{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.DataType

import IdrisGL.Color

{- Types -}

public export
data Rect : Type where
    MkRect : Int -> Int -> Int -> Int -> Rect

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

public export
data Event : Type where
    MkEvent : AnyPtr -> Event

{- Datas -}

public export
data Display
    --         title  size
    = InWindow String Rect
    | FullWindow

public export
data TextStyle   = TS_NORMAL | TS_BOLD  | TS_ITALIC | TS_UNDERLINE | TS_STRIKETHROUGH

public export
data TextHinting = TH_NORMAL | TH_LIGHT | TH_MONO   | TH_NONE

public export
data FlipSetting = FLIP_NONE | FLIP_HORIZONTAL | FLIP_VERTICAL

public export
data Picture
    = Blank
    | Pictures      (List Picture)
    --              Degree Center
    | Rotate        Double Coordinate Picture
    --              ZoomX  ZoomY
    -- | Scale         Double Double     Picture
    {- IMAGES -}
    --              Path   Size
    | Bitmap        String Rect
    | Image         String Rect
    --
    | Pixel         Coordinate Color
    {- Line -}
    --              Start      End              Thickness
    | ThickLine     Coordinate Coordinate Color Int
    | Line          Coordinate Coordinate Color
    {- Rectangle -}
    --                         Fill Radius
    | Rectangle     Rect Color Bool
    | R_Rectangle   Rect Color Bool Int
    {- Circle -}
    --              Center           Fill Radius Thickness
    | Circle        Coordinate Color Bool Int
    | ThickCircle   Coordinate Color      Int    Int
    {- Misc. -}
    -- Start : Starting radius in degrees of the arc. 0 degrees is down, increasing counterclockwise.
    -- End   :   Ending radius in degrees of the arc. 0 degrees is down, increasing counterclockwise. 
    --              Center           Radius Start End
    | Arc           Coordinate Color Int    Int   Int
    | Pie           Coordinate Color Int    Int   Int
    --              Center     Horizontal radius Vertical radius       Fill
    | Ellipse       Coordinate Int               Int             Color Bool
    --                                                     Fill
    | Trigon        Coordinate Coordinate Coordinate Color Bool
    | Polygon       (List Coordinate)                Color Bool
    {- Text -}
    --              Text   Size Font                    Shade                       Kerning
    | Text          String Int  String Coordinate Color 
    | SolidText     String Int  String Coordinate Color       TextStyle TextHinting Int
    | BlendedText   String Int  String Coordinate Color       TextStyle TextHinting Int
    | ShadedText    String Int  String Coordinate Color Color TextStyle TextHinting Int
