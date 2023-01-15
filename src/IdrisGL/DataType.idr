{- Tian Z (ecburx@burx.vip) -}

||| Data / Types
module IdrisGL.DataType

import IdrisGL.Color

{- Types -}

||| A rectangle used to determine an area.
public export
record Rect where
    constructor MkRect
    ||| @ x X coordinate of the start point.
    x : Int
    ||| @ y Y coordinate of the start point.
    y : Int
    ||| @ w The width of the rectangle area.
    w : Int
    ||| @ h The height of the rectangle area.
    h : Int

||| A coordinate used to determine the position.
public export
record Coordinate where
    constructor MkCoor
    ||| @ x X coordinate of the point.
    x : Int
    ||| @ y Y coordinate of the point.
    y : Int

{- Pinter Types -}

||| Surface.
||| A structure that contains a collection of pixels used in software blitting.
public export
record Sur where
    constructor MkSur
    ||| A wrapper of SDL_Surface pointer.
    ||| @ ptr The C pointer of a SDL_Surface. You should not directly operate this pointer.
    ptr : AnyPtr

||| Window.
public export
record Win where
    constructor MkWin
    ||| A wrapper of SDL_Window pointer.
    ||| @ ptr The C pointer of a SDL_Window. You should not directly operate this pointer.
    ptr : AnyPtr

||| Renderer.
||| A 2D rendering context for a window.
public export
record Renderer where
    constructor MkRenderer
    ||| A wrapper of SDL_Renderer pointer.
    ||| @ ptr The C pointer of a SDL_Renderer. You should not directly operate this pointer.
    ptr : AnyPtr

||| Texture.
||| A structure that contains an efficient, driver-specific representation of pixel data.
public export
record Texture where
    constructor MkTexture
    ||| A wrapper of SDL_Texture pointer.
    ||| @ ptr The C pointer of a SDL_Texture. You should not directly operate this pointer.
    ptr : AnyPtr

||| Event.
||| A union that contains structures for the different event types.
public export
record Event where
    constructor MkEvent
    ||| A wrapper of SDL_Event pointer.
    ||| @ ptr The C pointer of a SDL_Event. You should not directly operate this pointer.
    ptr : AnyPtr

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

||| 2D Picture.
public export
data Picture : Type where
    ||| A blank picture, with nothing in it.
    Blank : Picture
    ||| A picture consisting of several others.
    ||| @ pics    Other pictures.
    Pictures
      :  (pics : List Picture)
      -> Picture
    ||| A picture rotated clockwise by the given angle (in degrees) and given center.
    ||| @ angle   Rotation angle.
    ||| @ center  Rotation center.
    ||| @ pic     The picture to be rotated.
    Rotate
      :  (angle  : Double)
      -> (center : Coordinate)
      -> (pic    : Picture)
      -> Picture

    {-
        Images.
    -}

    ||| A bitmap image.
    ||| @ path The path of the bitmap.
    ||| @ rect The size and position of placed bitmap.
    Bitmap
      :  (path : String)
      -> (rect : Rect)
      -> Picture
    ||| An image in other format (PNG/JPG/WEBP/TIF).
    ||| @ path The path of the image.
    ||| @ rect The size and position of placed image.
    Image
      :  (path : String)
      -> (rect : Rect)
      -> Picture

    {-
        Shapes.
    -}

    ||| A pixel at given coordinate.
    ||| @ position The position of the pixel.
    ||| @ color    The color of the pixel.
    Pixel
      :  (position : Coordinate)
      -> (color    : Color)
      -> Picture
    ||| A thick line with given thickness.
    ||| @ start     The start position.
    ||| @ end       The end position.
    ||| @ color     The color of line.
    ||| @ thickness The thickness of line.
    ThickLine
      :  (start     : Coordinate)
      -> (end       : Coordinate)
      -> (color     : Color)
      -> (thickness : Int)
      -> Picture
    ||| A line.
    ||| @ start     The start position.
    ||| @ end       The end position.
    ||| @ color     The color of line.
    Line
      :  (start : Coordinate)
      -> (end   : Coordinate)
      -> (color : Color)
      -> Picture

    {-
        Rectangle
    -}

    ||| A rectangle.
    ||| @ rect    The size of position of the rectangle.
    ||| @ color   The color of the rectangle.
    ||| @ filling True if fill the rectangle.
    Rectangle
      :  (rect    : Rect)
      -> (color   : Color)
      -> (filling : Bool)
      -> Picture
    ||| A rounded-corner rectangle.
    ||| @ rect    The size of position of the rectangle.
    ||| @ color   The color of the rectangle.
    ||| @ filling True if fill the rectangle.
    ||| @ radius  The radius of the corner arc.
    R_Rectangle
      :  (rect    : Rect)
      -> (color   : Color)
      -> (filling : Bool)
      -> (radius  : Int)
      -> Picture

    {-
        Circle
    -}

    ||| A circle.
    ||| @ center  The center of the circle.
    ||| @ color   The color of the circle.
    ||| @ filling True if fill the circle.
    ||| @ radius  The radius of the circle.
    Circle
      :  (center  : Coordinate)
      -> (color   : Color)
      -> (filling : Bool)
      -> (radius  : Int)
      -> Picture
    ||| A circle with given thickness.
    ||| @ center    The center of the circle.
    ||| @ color     The color of the circle.
    ||| @ filling   True if fill the circle.
    ||| @ radius    The radius of the circle.
    ||| @ thickness The thickness of the drawing line.
    ThickCircle
      :  (center    : Coordinate)
      -> (color     : Color)
      -> (radius    : Int)
      -> (thickness : Int)
      -> Picture

    {-
        Misc.
    -}

    ||| A circular arc drawn counter-clockwise between two angles (in degrees).
    ||| @ center The center of the arc.
    ||| @ color  The color of drawing line.
    ||| @ radius The radius of the arc.
    ||| @ start  Starting radius in degrees of the arc. 0 degrees is down, increasing counterclockwise.
    ||| @ end    Ending radius in degrees of the arc. 0 degrees is down, increasing counterclockwise.
    Arc
      :  (center : Coordinate)
      -> (color  : Color)
      -> (radius : Int)
      -> (start  : Int)
      -> (end    : Int)
      -> Picture
    ||| A pie (outline) drawn counter-clockwise between two angles (in degrees).
    ||| @ center The center of the pie.
    ||| @ color  The color of drawing line.
    ||| @ radius The radius of the pie.
    ||| @ start  Starting radius in degrees of the arc. 0 degrees is down, increasing counterclockwise.
    ||| @ end    Ending radius in degrees of the arc. 0 degrees is down, increasing counterclockwise.
    Pie
      :  (center : Coordinate)
      -> (color  : Color)
      -> (radius : Int)
      -> (start  : Int)
      -> (end    : Int)
      -> (filled : Bool)
      -> Picture
    ||| An ellipse.
    ||| @ center  The center of the ellipse.
    ||| @ rx      Horizontal radius in pixels of the ellipse.
    ||| @ ry      Vertical radius in pixels of the ellipse.
    ||| @ color   The color of drawing line.
    ||| @ filling True if fill the ellipse.
    Ellipse
      :  (center  : Coordinate)
      -> (rx      : Int)
      -> (ry      : Int)
      -> (color   : Color)
      -> (filling : Bool)
      -> Picture
    ||| A trigon.
    ||| @ point1  The first point.
    ||| @ point2  The second point.
    ||| @ point3  The third point.
    ||| @ color   The color of drawing line.
    ||| @ filling True if fill the trigon.
    Trigon
      :  (point1  : Coordinate)
      -> (point2  : Coordinate)
      -> (point3  : Coordinate)
      -> (color   : Color)
      -> (filling : Bool)
      -> Picture
    ||| A polygon.
    ||| @ points  A list of points.
    ||| @ color   The color of drawing line.
    ||| @ filling True if fill the trigon.
    Polygon
      :  (points  : List Coordinate)
      -> (color   : Color)
      -> (filling : Bool)
      -> Picture

    {-
        Text
    -}

    ||| Blended text with default settings.
    ||| @ text  Text.
    ||| @ size  Font size.
    ||| @ font  Path of font file.
    ||| @ pos   Position of text.
    ||| @ color The color of text.
    Text
      :  (text  : String)
      -> (size  : Int)
      -> (font  : String)
      -> (pos   : Coordinate)
      -> (color : Color)
      -> Picture
    ||| Solid text.
    ||| @ text    Text.
    ||| @ size    Font size.
    ||| @ font    Path of font file.
    ||| @ pos     Position of text.
    ||| @ color   The color of text.
    ||| @ style   Font style.
    ||| @ hinting Hinting.
    ||| @ kerning Kerning.
    SolidText
      :  (text    : String)
      -> (size    : Int)
      -> (font    : String)
      -> (pos     : Coordinate)
      -> (color   : Color)
      -> (style   : TextStyle)
      -> (hinting : TextHinting)
      -> (kerning : Int)
      -> Picture
    ||| Blended text.
    ||| @ text    Text.
    ||| @ size    Font size.
    ||| @ font    Path of font file.
    ||| @ pos     Position of text.
    ||| @ color   The color of text.
    ||| @ style   Font style.
    ||| @ hinting Hinting.
    ||| @ kerning Kerning.
    BlendedText
      : (text     : String)
      -> (size    : Int)
      -> (font    : String)
      -> (pos     : Coordinate)
      -> (color   : Color)
      -> (style   : TextStyle)
      -> (hinting : TextHinting)
      -> (kerning : Int)
      -> Picture
    ||| Shaded text. (Blended text with background color)
    ||| @ text    Text.
    ||| @ size    Font size.
    ||| @ font    Path of font file.
    ||| @ pos     Position of text.
    ||| @ color   The color of text.
    ||| @ bgColor The background color.
    ||| @ style   Font style.
    ||| @ hinting Hinting.
    ||| @ kerning Kerning.
    ShadedText
      :  (text    : String)
      -> (size    : Int)
      -> (font    : String)
      -> (pos     : Coordinate)
      -> (color   : Color)
      -> (bgColor : Color)
      -> (style   : TextStyle)
      -> (hinting : TextHinting)
      -> (kerning : Int)
      -> Picture
