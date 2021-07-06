{- Tian Z (ecburx@burx.vip) -}

module ShowBMP

import IdrisGL

{- Show a bmp file.
  
   $ idris2 -p idrisGL IdrisGL.idr
   Main> :l "ShowBMP.idr"
   ShowBMP> :exec main
-}

-- The painless way to load a bmp:
main : IO ()
main = display 
    (InWindow "Show BMP" (MkRect 30 50 640 480))        -- window setting
    (MkColor 100 150 200 100)                           -- background color
    (Bitmap "hello_world.bmp" (MkRect 25 20 320 240))   -- Picture

-- Or you can customize details:
main' : IO ()
main' = do 
    win       <- createWin $ InWindow "Show BMP" (MkRect 30 50 640 480)
    screenSur <- getWinSur   win
    bmpSur    <- loadBMPSur "hello_world.bmp"
    loop         win         bmpSur screenSur
    freeSur      bmpSur
    closeWin     win
    where 
      loop : Win -> Sur -> Sur -> IO ()
      loop win bmp screen = do 
        scaledSur    bmp screen (MkRect 20 20 300 500)
        updateWinSur win
        case pollEve of
             E_QUIT => pure ()
             _      => loop win bmp screen