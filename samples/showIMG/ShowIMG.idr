{- Tian Z (ecburx@burx.vip) -}

module ShowIMG

import IdrisGL

{- Show an image file.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "ShowIMG.idr"
   ShowIMG> :exec main
-}

-- The painless way to load an image:
main : IO ()
main = display 
    (InWindow "Show BMP" (MkRect 30 50 640 480))        -- window setting
    (MkColor 100 150 255 100)                           -- background color
    (Image "loaded.png" (MkRect 25 20 320 240))         -- Picture

-- Or you can customize details:
main' : IO ()
main' = do 
    win       <- createWin $ InWindow "Show IMG" (MkRect 30 50 640 480)
    screenSur <- getWinSur   win
    imgSur    <- loadIMGSur "loaded.png"
    loop         win         imgSur screenSur
    freeSur      imgSur
    closeWin     win
    where 
      loop : Win -> Sur -> Sur -> IO ()
      loop win img screen = do 
        scaledSur    img screen (MkRect 20 20 300 500)
        updateWinSur win
        case pollEve of
             E_QUIT => pure ()
             _      => loop win img screen