module IdrisGL.Display

import IdrisGL.DataType
import IdrisGL.SDL.SDL_video
import IdrisGL.SDL.SDL_event
import IdrisGL.SDL.SDL_render
import IdrisGL.SDL.SDL_generic
import IdrisGL.SDL.SDL_surface
import IdrisGL.SDL.SDL_image

export
display : Display -> Color -> Picture -> IO ()
display mode color pic =  do 
    win                <- createWin mode
    ren                <- createRenderer win
    setRenderDrawColor    ren color

    t                  <- loadPicture pic ren
    loop                  pic ren t

    freeRender            ren
    closeWin              win

    where 
      loadPicture : Picture -> Renderer -> IO Texture
      loadPicture  Blank             ren =  pure $ MkTexture nullPtr
      loadPicture (Bitmap path rect) ren =  do
        bmpSur                           <- loadBMPSur path
        createTextureFromSur                ren bmpSur
      loadPicture (Image  path rect) ren =  do
        imgSur                           <- loadIMGSur path
        createTextureFromSur                ren imgSur
      loadPicture  _                  _  =  
        pure                             $  MkTexture nullPtr -- TODO

      loop' : IO () -> IO ()
      loop' l = 
        case pollEve                     of
             E_QUIT                      => pure ()
             _                           => l

      loop : Picture -> Renderer -> Texture -> IO ()
      loop  Blank             ren t      = do
        renderClear                        ren
        renderPresent                      ren
        loop'                            $ loop Blank ren t
      loop (Bitmap path rect) ren t      = do
        renderClear                        ren
        renderCopy                         ren t rect
        renderPresent                      ren
        loop'                            $ loop (Bitmap path rect) ren t
      loop (Image  path rect) ren t      = do
        renderClear                        ren
        renderCopy                         ren t rect
        renderPresent                      ren
        loop'                            $ loop (Image  path rect) ren t
      loop  _                 _   _      = pure ()                          -- TODO
 