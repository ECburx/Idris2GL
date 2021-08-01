{- Tian Z (ecburx@burx.vip) -}

module ShowIMG

import IdrisGL
import IdrisGL.SDL

{- Show an image file.
  
   $ idris2 -p idrisGL
   Main> :l "ShowIMG.idr"
   ShowIMG> :exec main
-}

-- The painless way to load an image:
main : IO ()
main = display 
    (InWindow "Show BMP" (MkRect 30 50 640 480))        -- window setting
    (MkRGBA 100 150 255 100)                            -- background color
    (Image "loaded.png" (MkRect 25 20 320 240))         -- Picture

-- Or you can customize details:
main' : IO ()
main' = do 
    win       <- createWin $ InWindow "Show IMG" (MkRect 30 50 640 480)
    screenSur <- getWinSur   win
    imgSur    <- loadIMGSur "loaded.png"
    e         <- newEve
    loop         win e imgSur screenSur
    freeSur      imgSur
    closeWin     win
    where 
      loop : Win -> Event -> Sur -> Sur -> IO ()
      loop win e img screen = do 
        scaledSur    img screen (MkRect 20 20 300 500)
        updateWinSur win
        case eveType e of
             E_QUIT => do freeEve e
                          pure ()
             _      => loop win e img screen