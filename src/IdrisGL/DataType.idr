{- Tian Z (ecburx@burx.vip) -}

||| Data / Types
module IdrisGL.DataType

import IdrisGL.Color

{- Types -}

||| A rectangle used to determine an area.
public export
data Rect : Type where
    ||| @ x X coordinate of the start point.
    ||| @ y Y coordinate of the start point.
    ||| @ w The width of the rectangle area.
    ||| @ h The height of the rectangle area.
    MkRect : (x : Int) -> (y : Int) -> (w : Int) -> (y : Int) -> Rect

||| A coordinate used to determine the position.
public export
data Coordinate : Type where
    ||| @ x X coordinate of the point.
    ||| @ y Y coordinate of the point.
    MkCoor : (x : Int) -> (y : Int) -> Coordinate

{- Pinter Types -}

||| Surface.
||| A structure that contains a collection of pixels used in software blitting.
public export
data Sur : Type where
    ||| A wrapper of SDL_Surface pointer.
    ||| @ ptr The C pointer of a SDL_Surface. You should not directly operate this pointer.
    MkSur : (ptr : AnyPtr) -> Sur

||| Window.
public export
data Win : Type where
    ||| A wrapper of SDL_Window pointer.
    ||| @ ptr The C pointer of a SDL_Window. You should not directly operate this pointer.
    MkWin : (ptr : AnyPtr) -> Win

||| Renderer.
||| A 2D rendering context for a window.
public export
data Renderer : Type where
    ||| A wrapper of SDL_Renderer pointer.
    ||| @ ptr The C pointer of a SDL_Renderer. You should not directly operate this pointer.
    MkRenderer : (ptr : AnyPtr) -> Renderer

||| Texture.
||| A structure that contains an efficient, driver-specific representation of pixel data.
public export
data Texture : Type where
    ||| A wrapper of SDL_Texture pointer.
    ||| @ ptr The C pointer of a SDL_Texture. You should not directly operate this pointer.
    MkTexture : (ptr : AnyPtr) -> Texture

||| Event.
||| A union that contains structures for the different event types.
public export
data Event : Type where
    ||| A wrapper of SDL_Event pointer.
    ||| @ ptr The C pointer of a SDL_Event. You should not directly operate this pointer.
    MkEvent : (ptr : AnyPtr) -> Event

{- Datas -}

||| Describes how IdrisGL should display its output.
public export
data Display
    = ||| Display in a window with the given name and area (size and position).
    InWindow String Rect
    | ||| Display full screen.
    FullWindow

||| Font styles.
public export
data TextStyle   = TS_NORMAL | TS_BOLD  | TS_ITALIC | TS_UNDERLINE | TS_STRIKETHROUGH

||| FreeType hinter settings.
public export
data TextHinting = TH_NORMAL | TH_LIGHT | TH_MONO   | TH_NONE

||| Flip settings for SDL bindings.
||| Instead you should avoid to use SDL bindings.
public export
data FlipSetting = FLIP_NONE | FLIP_HORIZONTAL | FLIP_VERTICAL

||| A 2D picture union.
public export
data Picture
    = ||| A blank picture, with nothing in it.
    Blank
    | ||| A picture consisting of several others.
    Pictures      (List Picture)
    | ||| A picture rotated clockwise by the given angle (in degrees) and given center.
      ||| : angle -> center of rotation -> picture -> Picture
    Rotate        Double Coordinate Picture
    {- 
        Images. 
    -}
    | ||| A bitmap image.
      ||| : path -> size and position -> Picture
    Bitmap        String Rect
    | ||| An image in other format (PNG/JPG/WEBP/TIF).
      ||| : path -> size and position -> Picture
    Image         String Rect
    {- 
        Shapes.
    -}
    | ||| A pixel at given coordinate.
      ||| : position -> color -> Picture
    Pixel         Coordinate Color
    | ||| A thick line with given thickness.
      ||| : start position -> end position -> color -> thickness -> Picture
    ThickLine     Coordinate Coordinate Color Int
    | ||| A line.
      ||| : start position -> end position -> color -> Picture
    Line          Coordinate Coordinate Color
    {- 
        Rectangle 
    -}
    | ||| A rectangle.
      ||| : size and position -> color -> fill? -> Picture
    Rectangle     Rect Color Bool
    | ||| A rounded-corner rectangle. 
      ||| : size and position -> color -> fill? -> radius of the corner arc -> Picture
    R_Rectangle   Rect Color Bool Int
    {- 
        Circle 
    -}
    | ||| A circle.
      ||| : center position -> color -> fill? -> radius -> Picture
    Circle        Coordinate Color Bool Int
    | ||| A circle with given thickness.
      ||| : center position -> color -> fill? -> radius -> thickness -> Picture
    ThickCircle   Coordinate Color Int Int
    {- 
        Misc. 
    -}
    | ||| A circular arc drawn counter-clockwise between two angles (in degrees).
      ||| : center position -> color -> radius -> first angles -> second angles -> Picture
    Arc           Coordinate Color Int Int Int
    | ||| A pie (outline) drawn counter-clockwise between two angles (in degrees).
      ||| : center position -> color -> radius -> first angles -> second angles -> Picture
    Pie           Coordinate Color Int Int Int
    | ||| An ellipse.
      ||| : center position -> horizontal radius -> vertical radius -> color -> fill? -> Picture
    Ellipse       Coordinate Int Int Color Bool
    | ||| A trigon.
      ||| : first point -> second point -> third point -> color -> fill? -> Picture
    Trigon        Coordinate Coordinate Coordinate Color Bool
    | ||| A polygon.
      ||| : list of points -> color -> fill ?
    Polygon       (List Coordinate) Color Bool
    {-
        Text
    -}
    --              Text   Size Font                    Shade                       Kerning
    | ||| Blended text with default settings.
      ||| : text -> font size -> font file -> position -> color -> Picture
    Text          String Int  String Coordinate Color 
    | ||| Solid text.
      ||| : text -> font size -> font file -> position -> color -> style -> hinting -> Picture
    SolidText     String Int  String Coordinate Color       TextStyle TextHinting Int
    | ||| Blended text.
      ||| : text -> font size -> font file -> position -> color -> style -> hinting -> Picture
      BlendedText   String Int  String Coordinate Color       TextStyle TextHinting Int
    | ||| Shaded text. (Blended text with background color)
      ||| : text -> font size -> font file -> position -> color -> style -> hinting -> Picture
      ShadedText    String Int  String Coordinate Color Color TextStyle TextHinting Int
