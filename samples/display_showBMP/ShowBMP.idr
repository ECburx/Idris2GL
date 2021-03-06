{- Tian Z (ecburx@burx.vip) -}

module ShowBMP

import IdrisGL
import IdrisGL.SDL

{- Show a bmp file.
  
   $ idris2 -p idrisGL
   Main> :l "ShowBMP.idr"
   ShowBMP> :exec main
-}

-- The painless way to load a bmp:
main : IO ()
main = display 
    (InWindow "Show BMP" (MkRect 30 50 640 480))                                 -- window setting
    (MkRGBA 100 150 200 100)                                                     -- background color
    (Rotate 10 (MkCoor 0 0) (Bitmap "hello_world.bmp" (MkRect 200 0 320 240)))   -- Picture

-- Or you can customize details:
main' : IO ()
main' = do 
    win       <- createWin $ InWindow "Show BMP" (MkRect 30 50 640 480)
    screenSur <- getWinSur   win
    bmpSur    <- loadBMPSur "hello_world.bmp"
    e         <- newEve
    loop         win e bmpSur screenSur
    freeSur      bmpSur
    closeWin     win
    where 
      loop : Win -> Event -> Sur -> Sur -> IO ()
      loop win e bmp screen =  do 
        scaledSur              bmp screen (MkRect 40 20 300 200)
        updateWinSur           win
        case eveType e      of
             E_QUIT         => do freeEve e
                                  pure ()
             _              => loop win e bmp screen