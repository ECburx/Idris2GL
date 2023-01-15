{- Tian Z (ecburx@burx.vip) -}

||| Loads pictures using SDL bindings.
module IdrisGL.Picture

import IdrisGL.DataType
import IdrisGL.Color
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_surface
import IdrisGL.SDL.SDL_image
import IdrisGL.SDL.SDL_gfx
import IdrisGL.SDL.SDL_ttf
import IdrisGL.SDL.SDL_mixer

||| Loads pictures using SDL bindings.
|||
||| @ pic Picture.
||| @ ren Renderer.
||| @ win Window.
export
loadPicture : (pic : Picture)
           -> (ren : Renderer)
           -> (win : Win)
           -> IO ()
loadPicture Blank                      _   _   =  pure ()

loadPicture (Pictures [])              _   _   =  pure ()
loadPicture (Pictures (x::xs))         ren win =  do
  loadPicture                                     x ren win
  loadPicture                                     (Pictures xs) ren win

loadPicture (Rotate degree center pic) ren win =  do
  texture                                      <- createTargetTexture win ren
  setRenderTarget                                 ren texture
  setRenderDrawColor                              ren transparent
  renderClear                                     ren
  loadPicture                                     pic ren win
  resetRenderTarget                               ren
  renderCopyExWin                                 win ren texture degree center FLIP_NONE

loadPicture (Bitmap      path rect)                  ren _   = loadBMP ren path rect
loadPicture (Image       path rect)                  ren _   = loadIMG ren path rect

loadPicture (Pixel       coordinate   color)               ren _   = pixel             ren coordinate color
loadPicture (ThickLine   start  end   color   thick)       ren _   = thickLine         ren start end color thick
loadPicture (Line        start  end   color)               ren _   = aaline            ren start end color
loadPicture (Rectangle   rect   color True)                ren _   = filledRect        ren rect   color
loadPicture (Rectangle   rect   color False)               ren _   = rectangle         ren rect   color
loadPicture (R_Rectangle rect   color True   rad)          ren _   = roundedFilledRect ren rect   color rad
loadPicture (R_Rectangle rect   color False  rad)          ren _   = roundedRect       ren rect   color rad
loadPicture (Circle      center color True   rad)          ren _   = filledCircle      ren center color rad
loadPicture (Circle      center color False  rad)          ren _   = aaCircle          ren center color rad
loadPicture (ThickCircle center color rad thick)           ren _   = thickCircle       ren center color rad thick
loadPicture (Arc         center color rad start end)       ren _   = arc               ren center color rad start end
loadPicture (Pie         center color rad start end True)  ren _   = filledPie         ren center color rad start end
loadPicture (Pie         center color rad start end False) ren _   = pie               ren center color rad start end
loadPicture (Ellipse     center rx ry color    True)       ren _   = filledEllipse     ren center rx ry color
loadPicture (Ellipse     center rx ry color   False)       ren _   = aaellipse         ren center rx ry color
loadPicture (Trigon      p1  p2 p3    color    True)       ren _   = filledTrigon      ren p1  p2 p3 color
loadPicture (Trigon      p1  p2 p3    color   False)       ren _   = aatrigon          ren p1  p2 p3 color

loadPicture (Polygon Nil      _    _)                      _   _   = pure ()
loadPicture (Polygon (p::ps) color False)                  ren win = polygon ren p (p::ps) color
  where polygon : Renderer -> Coordinate -> List Coordinate -> Color -> IO ()
        polygon       ren   fp (p1::p2::ps) color            = do
          loadPicture (Line p1  p2          color) ren win
          polygon     ren   fp (p2::ps)     color
        polygon       ren   fp [pn]         color            = loadPicture (Line pn fp color) ren win
        polygon       _     _  []           _                = pure ()
loadPicture (Polygon (p::ps) color True)             ren win = polygon ren p p (p::ps) color
  where polygon : Renderer -> Coordinate -> Coordinate -> List Coordinate -> Color -> IO ()
        polygon       ren     fp lp (p1::p2::ps) color       = do      -- FIXME: unexpected line color while alpha (rgba) is less than 255
          loadPicture (Trigon fp p1  p2          color True) ren win
          polygon     ren     fp p1 (p2::ps)     color
        polygon       _       _  _   _           _           = pure ()

loadPicture (Text        text size font p color)                               ren _ =
  drawText           ren text size font p color
loadPicture (SolidText   text size font p color         style hinting kerning) ren _ =
  drawSolidText      ren text size font style kerning hinting p color
loadPicture (BlendedText text size font p color         style hinting kerning) ren _ =
  drawBlendedText    ren text size font style kerning hinting p color
loadPicture (ShadedText  text size font p color1 color2 style hinting kerning) ren _ =
  drawShadedText     ren text size font style kerning hinting p color1 color2
