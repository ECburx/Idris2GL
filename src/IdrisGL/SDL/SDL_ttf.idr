{- Tian Z (ecburx@burx.vip) -}

module IdrisGL.SDL.SDL_ttf

import IdrisGL.DataType
import IdrisGL.Color

textStyle2Code : TextStyle -> Int
textStyle2Code TS_NORMAL        = 0
textStyle2Code TS_BOLD          = 1
textStyle2Code TS_ITALIC        = 2
textStyle2Code TS_UNDERLINE     = 3
textStyle2Code TS_STRIKETHROUGH = 4

textHinting2Code : TextHinting -> Int
textHinting2Code TH_NORMAL      = 0
textHinting2Code TH_LIGHT       = 1
textHinting2Code TH_MONO        = 2
textHinting2Code TH_NONE        = 3

{- 
    FFI 
-}

frgn : String -> String
frgn func = "C:" ++ func ++ ",sdl_ttf"

--

%foreign frgn "drawText"
prim_drawText : AnyPtr 
              -> String -> Int -> String
              -> Int -> Int
              -> Int -> Int -> Int -> Int
              -> PrimIO ()

||| Draw blended text to a renderer with default settings.
||| @ text Text.
||| @ size Font size.
||| @ font Path of font file.
export
drawText : HasIO io => Renderer
                    -> (text : String) -> (size : Int) -> (font : String)
                    -> Coordinate -> Color
                    -> io ()
drawText (MkRenderer ren) text size font (MkCoor x y) color
    = let (r,g,b,a) = rgbaOfColor color in
      primIO $ prim_drawText ren text size font x y r g b a

--

%foreign frgn "drawSolidText"
prim_drawSolidText : AnyPtr
                   -> String -> Int -> String
                   -> Int -> Int -> Int
                   -> Int -> Int
                   -> Int -> Int -> Int -> Int
                   -> PrimIO ()

||| Draw solid text to a renderer.
||| @ text    Text.
||| @ size    Font size.
||| @ font    Path of font file.
||| @ kerning Set freetype kerning setting.
export
drawSolidText : HasIO io => Renderer
                         -> (text : String) -> (size : Int) -> (font : String)
                         -> TextStyle -> (kerning : Int) -> TextHinting
                         -> Coordinate -> Color -> io ()
drawSolidText (MkRenderer ren) text size font style kerning hinting (MkCoor x y) color
    = let (r,g,b,a) = rgbaOfColor      color
          s         = textStyle2Code   style
          h         = textHinting2Code hinting in 
      primIO $ prim_drawSolidText ren text size font s kerning h x y r g b a

--

%foreign frgn "drawBlendedText"
prim_drawBlendedText : AnyPtr
                    -> String -> Int -> String
                    -> Int -> Int -> Int
                    -> Int -> Int
                    -> Int -> Int -> Int -> Int
                    -> PrimIO ()

||| Draw blended text to a renderer.
||| @ text    Text.
||| @ size    Font size.
||| @ font    Path of font file.
||| @ kerning Set freetype kerning setting.
export
drawBlendedText : HasIO io => Renderer 
                           -> (text : String) -> (size : Int) -> (font : String)
                           -> TextStyle -> (kerning : Int) -> TextHinting
                           -> Coordinate -> Color -> io ()
drawBlendedText (MkRenderer ren) text size font style kerning hinting (MkCoor x y) color
    = let (r,g,b,a) = rgbaOfColor      color 
          s         = textStyle2Code   style
          h         = textHinting2Code hinting in 
      primIO $ prim_drawBlendedText ren text size font s kerning h x y r g b a

--

%foreign frgn "drawShadedText"
prim_drawShadedText : AnyPtr
                    -> String -> Int -> String
                    -> Int -> Int -> Int
                    -> Int -> Int
                    -> Int -> Int -> Int -> Int
                    -> Int -> Int -> Int -> Int
                    -> PrimIO ()

||| Draw shaded text to a renderer.
||| @ text    Text.
||| @ size    Font size.
||| @ font    Path of font file.
||| @ kerning Set freetype kerning setting.
||| @ color1  The color to render the text in.
||| @ color2  The color to render the background box in.
export
drawShadedText : HasIO io => Renderer 
                          -> (text : String) -> (size : Int) -> (font : String)
                          -> TextStyle -> (kerning : Int) -> TextHinting
                          -> Coordinate -> (color1 : Color) -> (color2 : Color) 
                          -> io ()
drawShadedText (MkRenderer ren) 
    text size font 
    style kerning hinting 
    (MkCoor x y) color1 color2
    = let (r1,g1,b1,a1) = rgbaOfColor color1
          (r2,g2,b2,a2) = rgbaOfColor color2
          s             = textStyle2Code style
          h             = textHinting2Code hinting in
      primIO $ prim_drawShadedText ren text size font s kerning h x y r1 g1 b1 a1 r2 g2 b2 a2