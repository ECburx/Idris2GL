module IdrisGL.Display

import IdrisGL.DataType
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_generic
import IdrisGL.SDL.SDL_surface
import IdrisGL.SDL.SDL_image
import IdrisGL.SDL.SDL_gfx
import IdrisGL.SDL.SDL_ttf

export
display : Display -> Color -> Picture -> IO ()
display mode color pic =  do 
    win                <- createWin mode
    ren                <- createRenderer win
    setRenderDrawColor    ren color

    renderClear           ren
    loadPicture pic       ren
    renderPresent         ren
    loop

    freeRender            ren
    closeWin              win

    where
      loadPicture : Picture -> Renderer -> IO ()
      loadPicture Blank              ren = pure ()
  
      loadPicture (Pictures (x::xs)) ren = do
        loadPicture      x ren
        loadPicture      (Pictures xs) ren

      loadPicture (Bitmap path rect) ren = do
        bmpSur        <- loadBMPSur path
        texture       <- createTextureFromSur ren bmpSur
        renderCopy       ren texture rect
      loadPicture (Image path rect)  ren = do
        imgSur        <- loadIMGSur path
        texture       <- createTextureFromSur ren imgSur
        renderCopy       ren texture rect

      loadPicture (Pixel       coordinate           color) ren = pixel             ren coordinate color
      loadPicture (ThickLine   start  end   color   thick) ren = thickLine         ren start end color thick
      loadPicture (Line        start  end           color) ren = aaline            ren start end color
      loadPicture (Rectangle   rect   color          True) ren = filledRect        ren rect   color
      loadPicture (Rectangle   rect   color         False) ren = rectangle         ren rect   color
      loadPicture (R_Rectangle rect   color True      rad) ren = roundedFilledRect ren rect   color rad
      loadPicture (R_Rectangle rect   color False     rad) ren = roundedRect       ren rect   color rad
      loadPicture (Circle      center color True      rad) ren = filledCircle      ren center color rad
      loadPicture (Circle      center color False     rad) ren = aaCircle          ren center color rad
      loadPicture (Arc         center color rad start end) ren = arc               ren center color rad start end
      loadPicture (Ellipse     center rx ry color    True) ren = filledEllipse     ren center rx ry color
      loadPicture (Ellipse     center rx ry color   False) ren = aaellipse         ren center rx ry color
      loadPicture (Pie         center color rad start end) ren = pie               ren center color rad start end
      loadPicture (Trigon      p1  p2 p3    color    True) ren = filledTrigon      ren p1  p2 p3 color
      loadPicture (Trigon      p1  p2 p3    color   False) ren = aatrigon          ren p1  p2 p3 color

      loadPicture (Text text   size font p  color)         ren = drawText          ren text size font p color
      loadPicture (SolidText   text size font p color         style hinting kerning) ren =
        drawSolidText   ren text size font style kerning hinting p color
      loadPicture (BlendedText text size font p color         style hinting kerning) ren =
        drawBlendedText ren text size font style kerning hinting p color
      loadPicture (ShadedText  text size font p color1 color2 style hinting kerning) ren =
        drawShadedText  ren text size font style kerning hinting p color1 color2

      loadPicture (Polygon (p::ps) color False)            ren = polygon           ren p (p::ps) color
        where polygon : Renderer -> Coordinate -> List Coordinate -> Color -> IO ()
              polygon ren fp (p1::p2::ps) color                = do
                loadPicture (Line p1  p2  color) ren
                polygon ren fp (p2::ps)   color
              polygon   ren fp [pn]       color                = loadPicture (Line pn fp color) ren
              polygon   _   _  []   _                          = pure ()
      loadPicture (Polygon (p::ps) color True)             ren = polygon           ren p p (p::ps) color
        where polygon : Renderer -> Coordinate -> Coordinate -> List Coordinate -> Color -> IO ()
              polygon   ren fp lp  (p1::p2::ps) color          = do      -- FIXME: unexpected line color while alpha (rgba) is less than 255
                loadPicture (Trigon fp  p1  p2  color True) ren
                polygon ren fp p1  (p2::ps)     color
              polygon   _   _  _   _            _              = pure ()

      loadPicture  _ _                                         = pure ()

      loop : IO ()
      loop = 
        case pollEve                                           of
             E_QUIT                                            => pure ()
             _                                                 => loop